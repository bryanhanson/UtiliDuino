#'
#' Create a Temporary Workspace for Compiling Sketches
#'
#' @param sketch_full_name Character.  The full path to the sketch.
#'
#' @return A character string giving the path to the temporary directory.
#' 
#' @author Bryan A. Hanson
#' @importFrom tools file_path_sans_ext
#' @export
#'
ud_setup_workspace <- function(sketch_full_name = NULL) {
  
  if (is.null(sketch_full_name)) stop("Missing full name of sketch")
  cwd <- getwd()
  on.exit(setwd(cwd))

  # create a temp work space
  # within it, create a dedicated subfolder with the proper name
  td <- tempdir()  
  setwd(td)
  sub <- file_path_sans_ext(basename(sketch_full_name))
  if (!dir.exists(sub)) dir.create(sub)
  subdir <- file.path(td, sub)
  
  # copy all the files
  pat <- c("\\.ino", "\\.h", "\\.cxx", "\\.cc")
  files <- list.files(path = dirname(sketch_full_name), pattern = pat, full.names = TRUE)
  chk <- file.copy(from = files, to = subdir, overwrite = TRUE)
  if (any(!chk)) stop("sketch copy failed")

  return(subdir)
}
