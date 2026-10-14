import jsPDF from "jspdf";
import html2canvas from "html2canvas";

/**
 * Exports a DOM element (typically the rendered score) to a paginated PDF.
 * The element is rasterized with html2canvas, then sliced across multiple
 * A4 pages if needed.
 *
 * @param element - The DOM element to capture
 * @param title - Title of the score, used for the filename
 */
export async function exportElementToPdf(
  element: HTMLElement,
  title: string,
): Promise<void> {
  // Render to a high-resolution canvas for print quality
  const canvas = await html2canvas(element, {
    scale: 2,
    useCORS: true,
    backgroundColor: "#ffffff",
    logging: false,
    windowWidth: element.scrollWidth,
    windowHeight: element.scrollHeight,
  });

  const pdf = new jsPDF({
    orientation: "portrait",
    unit: "pt",
    format: "a4",
  });

  const pageWidth = pdf.internal.pageSize.getWidth();
  const pageHeight = pdf.internal.pageSize.getHeight();
  const margin = 28;
  const usableWidth = pageWidth - margin * 2;

  // Scale image to fit page width
  const imgRatio = canvas.height / canvas.width;
  const imgWidth = usableWidth;
  const imgHeight = imgWidth * imgRatio;

  let remainingHeight = imgHeight;
  let sourceY = 0;
  let isFirstPage = true;
  const pageAvailableHeight = pageHeight - margin * 2;

  while (remainingHeight > 0) {
    if (!isFirstPage) pdf.addPage();
    isFirstPage = false;

    const sliceHeight = Math.min(pageAvailableHeight, remainingHeight);
    const sliceHeightPx = (sliceHeight / imgHeight) * canvas.height;

    // Extract a horizontal slice of the canvas
    const sliceCanvas = document.createElement("canvas");
    sliceCanvas.width = canvas.width;
    sliceCanvas.height = sliceHeightPx;

    const ctx = sliceCanvas.getContext("2d");
    if (ctx) {
      ctx.drawImage(
        canvas,
        0,
        sourceY,
        canvas.width,
        sliceHeightPx,
        0,
        0,
        canvas.width,
        sliceHeightPx,
      );
    }

    const imgData = sliceCanvas.toDataURL("image/png");
    pdf.addImage(imgData, "PNG", margin, margin, imgWidth, sliceHeight);

    sourceY += sliceHeightPx;
    remainingHeight -= sliceHeight;
  }

  // Save with a sanitized filename
  const slug = (title || "score")
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-|-$/g, "");
  pdf.save(`${slug}-appnota.pdf`);
}