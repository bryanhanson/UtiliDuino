#'
#' Compile and Upload a Sketch to an Arduino Board
#'
#' The basic steps are identical
#' to the Arduino IDE: the files are compiled and uploaded and the binary executes automatically.
#' If a sketch works in the IDE it should work here (to be clear, the IDE is the place for sketch
#' development, this package is intended for data capture).
#'
#' The sketch and any other files in the same directory are copied to a temporary directory
#' with the same name as the sketch, then compiled and uploaded.
#' The folder structure should be exactly as with the Arduino IDE: a sketch
#' named `sketch.ino` must be in a folder named `sketch`, along with any other `.ino`, `.cpp`,
#' `.cxx`, `.cc`. and
#' `.h` files (or any file type that Arduino will accept - all files are copied w/o any check
#' about suitability.  File types are hard-coded in `ud_setup_workspace()`).
#' Once uploaded, the Arduino executes the program automatically, as it does in the
#' Arduino IDE.
#'
#' @param comp_arg_string Character.  A string giving compiler arguments.  If missing (the
#'        the default), a simple but suitable set of arguments are used.  You do not need to
#'        include `arduino-cli`, just the arguments that would follow.
#' @param upload_arg_string Character.  A string giving upload arguments.  If missing (the
#'        the default), a simple but suitable set of arguments are used.  You do not need to
#'        include `arduino-cli`, just the arguments that would follow.
#' @param conn Character.  The name of an open connection.
#' @param board Character.  A FQBN (Fully Qualified Board Name).
#' @param sketch Character.  A string giving the name of an `.ino` sketch to compile and upload.
#'        Include the `.ino` extension.
#'
#' @return `NULL`. The name of the sketch will be printed in the console if upload is
#'          successful.
#'
#' @author Bryan A. Hanson
#' @importFrom tools file_path_sans_ext
#' @export
#'
#' @examples
#' \dontrun{
#' # An Arduino must be plugged into a serial port to run these examples.
#'
#' currDir <- getwd()
#'
#' # Sketch #1: Counts to 100 repeatedly, prints 20 numbers per line
#'
#' setwd(system.file("extdata", "sketch1", package = "UtiliDuino"))
#' udc <- ud_open_connection()
#' jnk <- ud_compile_upload("sketch1.ino", conn = udc)
#' Sys.sleep(5) # wait for upload to complete and comms to settle
#' out <- ud_capture_serial(udc, clean = TRUE, sep = "\\r")
#' ud_close_connection(udc)
#'
#' # check output (data is long strings of integers on multiple lines)
#' tmp <- scan(text = paste(out, collapse = " "))
#' tmp <- order(unique(tmp))
#' all.equal(tmp, 1:100) # should be TRUE
#'
#' # Sketch #2: Queries the values of some registers after receiving a "go" signal
#'
#' setwd(system.file("extdata", "sketch2", package = "UtiliDuino"))
#' udc <- ud_open_connection()
#' jnk <- ud_compile_upload("sketch2.ino", conn = udc)
#' Sys.sleep(5) # wait for upload to complete and comms to settle
#' write.serialConnection(udc, "g")
#' Sys.sleep(5)
#' out <- ud_capture_serial(udc, clean = TRUE, sep = "\\r")
#' ud_close_connection(udc)
#'
#' # check output (register names and values, one per line, possibly with " Arduino listening...")
#' tmp <- unique(out)
#' ucsr0c <- grepl("UCSR0C register: 0000 0110", tmp)
#' isTRUE(any(ucsr0c)) # should be TRUE
#' adcsra <- grepl("ADCSRA register: 1000 0111", tmp)
#' isTRUE(any(adcsra)) # should be TRUE
#'
#' setwd(currDir)
#' }
#'
ud_compile_upload <- function(sketch = NULL,
                              board = "arduino:avr:uno",
                              conn = NULL,
                              comp_arg_string = NULL,
                              upload_arg_string = NULL) {
  if (is.null(conn)) stop("You must provide the name of an open serial connection")
  if (is.null(sketch)) stop("You must provide a .ino sketch")
  port <- ud_get_port()
  uport <- port[2]
  port <- port[1]

  ard_path <- ud_get_arduino_path()

  # verify sketch exists
  cat(sketch, "\n")
  sketch_full_name <- normalizePath(sketch)
  chk <- file.exists(sketch_full_name)
  if (!chk) stop("Could not find the sketch you specified")
  sketch_name <- basename(sketch_full_name)

  # copy the sketch and any other files in the same folder, to a temp dir for compiling
  cwd <- getwd()
  on.exit(setwd(cwd))
  td <- ud_setup_workspace(sketch_full_name) # returns path to dedicated subdir in a tmp dir
  setwd(td)

  # compile the sketch
  if (is.null(comp_arg_string)) comp_arg_string <- paste("compile -b", board, sketch_name, sep = " ")
  system2(ard_path, comp_arg_string, stdout = TRUE, stderr = TRUE)

  # upload the sketch
  if (is.null(upload_arg_string)) {
    upload_arg_string <-
      paste("upload -b", board, "-p", uport, sketch_name, sep = " ")
  }
  system2(ard_path, upload_arg_string, stdout = TRUE, stderr = TRUE)

  return(NULL)
}
