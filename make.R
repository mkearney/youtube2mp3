# youtube2mp3
## Package make file

## load the first scriptorium emporium
library(tfse)

## update/document package
make_package()

## update git repo
add_to_git("clean up make file")
1

## download everclear song
youtube2mp3(
  "https://www.youtube.com/watch?v=MW6E_TNgCsY",
  "~/Music/everclear-santamonica.mp3"
)
## foo fighters - monkey wrench
youtube2mp3(
  "https://www.youtube.com/watch?v=I7rCNiiNPxA",
  "~/Music/foofighters-monkeywrench.mp3"
)
## haley reinhart - creep
youtube2mp3(
  "https://www.youtube.com/watch?v=m3lF2qEA2cw",
  "~/Music/reinhart-creep.mp3"
)
## haley reinhart - time of my life
youtube2mp3(
  "https://www.youtube.com/watch?v=WsxdsTdcgJ4",
  "~/Music/reinhart-timeofmylife.mp3"
)


##----------------------------------------------------------------------------##
##                                    tuber                                   ##
##----------------------------------------------------------------------------##

## search using youtube api
if (!"tube" %in% installed.packages()) {
  devtools::install_github(
    "soodoku/tuber",
    build_vignettes = TRUE
  )  
}

## oauthorize yahoo api sesssion
tuber::yt_oauth(
  Sys.getenv("YOUTUBE_APP_ID"),
  Sys.getenv("YOUTUBE_APP_SECRET"),
)

## search for leftovers theme
x <- tuber::yt_search('leftovers')
pos <- grep("leftover.*theme", x$title, ignore.case = TRUE)

## view search hits with leftovers and theme
x$title[pos]

## select video to convert to mp3
vid <- as.character(x$video_id[1])

## pass vid to youtube2mp3 fun
youtube2mp3(vid)

## once video has converted enter "1" to proceed with download
1
