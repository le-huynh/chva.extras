make_obs_df <- function() {
  data.frame(
    timestamp = c("2024-03-01 06:50:00",
                  "2024-03-01 06:53:00",
                  "2024-03-01 07:10:00",
                  "2024-03-01 07:30:00",
                  "2024-03-01 07:55:00"),
    temperature = c(15, NA, 16, NA, 17)
  )
}

test_that("get_weather_obs() returns the max of the closest observations", {
  # 06:50 and 07:10 are both 10 min away -> max(15, 16)
  res <- get_weather_obs(make_obs_df(),
                         target_column = temperature,
                         timestamp_column = timestamp,
                         target_hour = 7,
                         target_minute = 0,
                         time_window = 30)
  expect_equal(res, 16)
})

test_that("get_weather_obs() skips NA observations", {
  # 06:53 is closest to 06:55 but NA -> 06:50 (5 min) is used
  res <- get_weather_obs(make_obs_df(),
                         target_column = temperature,
                         timestamp_column = timestamp,
                         target_hour = 6,
                         target_minute = 55,
                         time_window = 30)
  expect_equal(res, 15)
})

test_that("get_weather_obs() accepts a column name via rlang::sym()", {
  res <- get_weather_obs(make_obs_df(),
                         target_column = !!rlang::sym("temperature"),
                         timestamp_column = timestamp,
                         target_hour = 7,
                         target_minute = 55,
                         time_window = 10)
  expect_equal(res, 17)
})

test_that("get_weather_obs() returns NA when no observation is in the window", {
  res <- suppressWarnings(
    get_weather_obs(make_obs_df(),
                    target_column = temperature,
                    timestamp_column = timestamp,
                    target_hour = 12,
                    target_minute = 0,
                    time_window = 30)
  )
  expect_true(is.na(res))
})
