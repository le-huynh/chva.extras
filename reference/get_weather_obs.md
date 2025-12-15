# Get observation closest to a specific time

Extract the maximum available weather observation closest to a specified
target time within a given time window. If no valid observations are
found, return `NA`.

## Usage

``` r
get_weather_obs(
  data,
  target_column,
  timestamp_column,
  target_hour,
  target_minute,
  time_window
)
```

## Arguments

- data:

  A data frame containing weather observations.

- target_column:

  The meteorological variable to retrieve.

- timestamp_column:

  The column containing timestamps of the observations.

- target_hour:

  An integer specifying the target hour (0-23) for retrieving
  observations.

- target_minute:

  An integer specifying the target minute (0-59) for retrieving
  observations.

- time_window:

  An integer specifying the allowable time window (in minutes) around
  the target time.

## Value

A numeric value or `NA`.

## References

Davis, Robert E., Owen Himmel, Parker K. Sims, and Christopher M.
Fuhrmann. “Mortality and Diurnal Temperature Range in Virginia.”
International Journal of Biometeorology, January 30, 2025.
<https://doi.org/10.1007/s00484-025-02850-6>

## Examples

``` r
df <- data.frame(
  timestamp = (c("2024-03-01 06:50:00",
                 "2024-03-01 06:53:00",
                 "2024-03-01 07:10:00",
                 "2024-03-01 07:30:00",
                 "2024-03-01 07:55:00")),
  temperature = c(15, NA, 16, NA, 17)
)

# retrieve the closest temperature observation around 07:00 within a 30-minute window
get_weather_obs(df,
                target_column = temperature,
                timestamp_column = timestamp,
                target_hour = 7,
                target_minute = 0,
                time_window = 30)
#> [1] 16

# Note: Use `!!rlang::sym()` if `target_column` or `timestamp_column`
# is provided as a character string.

get_weather_obs(df,
                target_column = "temperature",
                timestamp_column = timestamp,
                target_hour = 7,
                target_minute = 0,
                time_window = 30)
#> [1] NA

get_weather_obs(df,
                target_column = !!rlang::sym("temperature"),
                timestamp_column = timestamp,
                target_hour = 7,
                target_minute = 0,
                time_window = 30)
#> [1] 16
```
