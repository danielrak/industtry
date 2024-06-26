# WARNING - Generated by {fusen} from dev/flat_paths_and_files.Rmd: do not edit by hand

test_that("Structures are effectively the same", {
  
  library(magrittr)
  
  temp_dir_to_replicate <- tempfile()
  dir.create(temp_dir_to_replicate)
  
  dir.create(file.path(temp_dir_to_replicate, "dir1"))
  dir.create(file.path(temp_dir_to_replicate, "dir2"))
  
  temp_dir_out <- tempfile()
  dir.create(temp_dir_out)
  
  folder_structure_replicate(
  dir = temp_dir_to_replicate, 
  to = temp_dir_out)
  
  ldir_in <- temp_dir_to_replicate %>% 
    (\(t) list.dirs(t) %>% 
       (\(l) l[l != t]))
  ldir_out <- temp_dir_to_replicate %>% 
    (\(t) list.dirs(t) %>% 
       (\(l) l[l != t]))
  
  expect_identical(
    object = ldir_in, 
    expected = ldir_out
  )
})
