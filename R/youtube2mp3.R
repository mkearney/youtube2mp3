#' youtube2mp3
#'
#' Converts youtube links to mp3s.
#' 
#' @param video_id Youtube's assigned unique identifier; also accepted is a
#'   link to a youtube video URL, though if a URL is provided, it must
#'   include "youtube.com/watch?v=".
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
youtube2mp3 <- function(video_id, file = NULL) {
  stopifnot(is.character(video_id), length(video_id) == 1L)
  if (grepl("^http|^www", video_id)) {
    stopifnot(grepl("www\\.youtube\\.com\\/watch\\?v\\=", video_id))
    video_id <- gsub(".*=", "", video_id)
  }
  mp3_url <- paste0(
    "http://www.yt-mp3.com/watch?v=",
    video_id
  )
  tfse::menuline
  browseURL(mp3_url)
  sh <- menuline(
    "Has the video \"successfully been converted\" yet?",
    c("Yes", "No"))
  if (sh == 2L) {
    stop("Well then I don't know what to tell you", call. = FALSE)
  }
  r <- httr::GET(mp3_url)
  httr::stop_for_status(r)
  txt <- httr::content(r, "text", encoding = "UTF-8")
  m <- gregexpr("(?<=video_url\":\")[^\"]*(?=\"\\})", txt, perl = TRUE)
  m <- regmatches(txt, m)[[1]]
  if (is.null(file)) {
    file <- paste0(video_id, ".mp3")
  } else if (!grepl("\\.mp3$", file)) {
    file <- paste0(file, ".mp3")
  }
  stopifnot(is.character(file))
  vidurl <- paste0("http:", gsub("\\/video", "", m))
  stopifnot(length(vidurl) == 1, is.character(vidurl))
  message("Download link is ", vidurl)
  download.file(vidurl, file)
}

menuline <- function(q, a) {
  message(q)
  menu(a)
}
