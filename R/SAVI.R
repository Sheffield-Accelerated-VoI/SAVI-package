#' @export
SAVI <- function() {
  appDir <- system.file("SAVI", package = "SAVI")
  if (appDir == "") {
    stop("Could not find SAVI directory. Try re-installing `SAVI`.", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal", launch.browser = TRUE)
}