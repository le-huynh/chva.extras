% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/delete_csv.R
\name{delete_csv}
\alias{delete_csv}
\title{Delete multiple CSV files}
\usage{
delete_csv(folder_path, pattern)
}
\arguments{
\item{folder_path}{A string path to the directory containing sub-directories
of the files to be deleted.}

\item{pattern}{A string to filter the sub-directories of csv files by names.}
}
\value{
The deleted paths (invisibly).
}
\description{
This function is executed after converting CSV files to Parquet format using
\code{\link[=get_parquet_arrow]{get_parquet_arrow()}} or \code{\link[=get_parquet_by_chunk]{get_parquet_by_chunk()}}.
It deletes the original CSV files from the sub-folders in the specified folder,
once they have been successfully converted to Parquet. The function filters
sub-folders by the provided pattern and deletes the corresponding CSV files.
}
\examples{
\dontrun{
delete_csv(folder_path = "path/to/data_folder", pattern = "Facility")
}

}
