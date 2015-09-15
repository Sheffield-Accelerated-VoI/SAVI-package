#' @export
SAVI <- function() {
  appDir <- system.file("SAVI", package = "SAVILocal")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `SAVILocal`.", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal", launch.browser = TRUE)
}