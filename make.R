## R make file
devtools::document()
devtools::install()

# install.packages("devtools")

if (!"tube" %in% installed.packages()) {
  devtools::install_github(
    "soodoku/tuber",
    build_vignettes = TRUE
  )  
}

## oautherize yahoo api sesssion
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
