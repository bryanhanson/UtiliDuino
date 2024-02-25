#'
#' Close the Connection to an Arduino Board
#'
#' @param ud_conn Character.  The name of an open connection object.
#'
#' @author Original code by Chris Suh and Peter Hoff.
#' @import serial
#' @export
#'
ud_close_connection <- function(ud_conn) {
  close(ud_conn)
}
