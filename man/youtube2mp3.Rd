% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/youtube2mp3.R
\name{youtube2mp3}
\alias{youtube2mp3}
\title{youtube2mp3}
\usage{
youtube2mp3(video_id, file = NULL)
}
\arguments{
\item{video_id}{Youtube's assigned unique identifier; also accepted is a
link to a youtube video URL, though if a URL is provided, it must
include "youtube.com/watch?v=".}

\item{file}{Name of output mp3 file. A ".mp3" file extension will be added if not
already included. This defaults to the video code (value after v= in the URL) and
saved in the current working directory.}
}
\value{
Saves output as file name.
}
\description{
Converts youtube links to mp3s.
}
\examples{
\dontrun{
## download mp3 of leftovers piano theme by max richter
youtube2mp3(
  "https://www.youtube.com/watch?v=UVvOLhJd44Q",
  file = "leftovers-theme.mp3"
)
}
}
