check_dots_empty <- function(...) {
  if (dots_n(...) == 0L) {
    return(invisible())
  }

  abort(paste0(
    "`...` is not empty.\n",
    "These dots only exist to allow for future extensions, and should be empty.\n",
    "Did you misspecify an argument?"
  ))
}
