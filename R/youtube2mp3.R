#' youtube2mp3
#'
#' Converts youtube links to mp3s.
#' 
#' @param youtube_url Link to youtube video. URL must include "youtube.com/watch?v=".
#' @param file Name of output mp3 file. A ".mp3" file extension will be added if not
#'   already included. This defaults to the video code (value after v= in the URL) and
#'   saved in the current working directory.
#' @return Saves output as file name.
#' @export
#' @examples
#' \dontrun{
#' ## download mp3 of leftovers piano theme by max richter
#' youtube2mp3(
#'   "https://www.youtube.com/watch?v=UVvOLhJd44Q",
#'   file = "leftovers-theme.mp3"
#' )
#' }
#' @importFrom httr GET content stop_for_status
youtube2mp3 <- function(youtube_url, file = NULL) {
  stopifnot(grepl("www\\.youtube\\.com\\/watch\\?v\\=", youtube_url))
  youtube_code <- gsub(".*=", "", youtube_url)
  mp3_url <- paste0(
    "http://www.yt-mp3.com/watch?v=",
    youtube_code
  )
  txt <- httr::GET(mp3_url)
  httr::stop_for_status(txt)
  txt <- httr::content(txt, "text", encoding = "UTF-8")
  m <- gregexpr("(?<=video_url\":\")[^\"]*(?=\"\\})", txt, perl = TRUE)
  vidurl <- regmatches(txt, m)
  vidurl <- paste0("http:", gsub("\\/video", "", vidurl))
  if (is.null(file)) {
    file <- paste0(youtube_code, ".mp3")
  } else if (!grepl("\\.mp3$", file)) {
    file <- paste0(file, ".mp3")
  }
  stopifnot(is.character(file))
  download.file(vidurl, file)
}
