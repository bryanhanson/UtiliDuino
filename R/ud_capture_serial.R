#'
#' Capture Data Sent to the Serial Port by Arduino
#'
#' @param ud_conn Character.  The name of an open connection object.
#' @param clean Logical.  Shall the data be cleaned of spurious entries?  If so,
#'        empty strings (" ") and leading/trailing white space will be removed.
#'        Further manual cleaning may be needed to get usable data.
#' @param sep Character.  A character string giving a separator that (may) separate
#'        individual data entries in the serial string.  Used in cleaning the entries.
#'
#' @return Character.  The (possibly cleaned) data stream.
#'
#' @author Bryan A. Hanson
#' @export
#'
ud_capture_serial <- function(ud_conn, clean = FALSE, sep = NULL) {
  res <- read.serialConnection(ud_conn)
  if (clean) {
  res <- unlist(strsplit(res, sep))
  	keep <- which(res != " ")
  	res <- res[keep]
  	res <- trimws(res)
  }
  return(res)
}


