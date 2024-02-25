#'
#' Open a Serial Connection to an Arduino Board
#'
#' **The Arduino board must be plugged in for its port to be found, and a connection opened.**
#'
#' @param baud Integer. The baud rate.  Should match the rate specified in an `.ino` file that
#'        will be compiled and uploaded.
#' @param mode Character vector with three elements.  The communication mode.
#'        See [serial::serialConnection()] for details.
#' @return None.  A serial connection is opened.
#'
#' @author Original code by Chris Suh and Peter Hoff, with modifications by Bryan A. Hanson
#' @export
#'
ud_open_connection <- function(baud = 9600, mode = "n,8,1") {
  port <- ud_get_port()[1]

  ud_conn <- serialConnection(
    name = "udconn", port = port,
    mode = paste(baud, mode, sep = ","), buffering = "none",
    newline = 1, translation = "lf"
  )

  open(ud_conn)
  Sys.sleep(3) # allow time for connection to stabilize
  return(ud_conn)
}
