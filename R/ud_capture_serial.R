#'
#' Capture Data Sent to the Serial Port by Arduino
#'
#' @param ud_conn Character.  The name of an open connection object.
#'
#' @return Character.  The (possibly cleaned) data stream.
#'
#' @author Bryan A. Hanson
#' @export
#'
ud_capture_serial <- function(ud_conn) {
  res <- read.serialConnection(ud_conn)
  return(res)
}
