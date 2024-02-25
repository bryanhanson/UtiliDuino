#'
#' Find a Serial Port
#'
#' @return Character vector with two elements.  The name of the port, formatted in two ways.
#'
#' **The Arduino board must be plugged in for its port to be found.**
#'
#' @author Original code by Chris Suh and Peter Hoff, with modifications by Bryan A. Hanson
#'
#' @export
#'
ud_get_port <- function() {
  if (version$os == "linux-gnu") { # UNTESTED !
    port <- list.files(path = "/dev/serial/by-id")
    port <- Sys.readlink(paste("/dev/serial/by-id/", port, sep = ""))
    uport <- port
    port <- gsub("../", "", port)
  } else if (grepl("darwin", version$os)) {
    port <- suppressMessages(listPorts())
    port <- port[grep("modem", port)[1]]
    uport <- port
    port <- paste("/dev/", port, sep = "")
    port <- gsub("tty", "cu", port) # does not appear to be necessary
  } else {
    stop("Other platforms not supported")
  }

  if (is.na(uport) || is.na(port)) stop("Port not found.  Is the Arduino plugged in?")
  return(c(uport, port))
}
