# Load required packages
require(data.table)
require(scales)
require(ggplot2)

# -----------------------------
# Define input/output directories
# -----------------------------
input_wgs_dir <- '/workspaces/lps_paper/evaluation/downstream/data/raw_prs_scores/'    # WGS PRS files
input_array_dir <- '/workspaces/lps_paper/evaluation/downstream/data/raw_prs_scores/'  # Array PRS files
output_dir <- '/workspaces/lps_paper/evaluation/downstream/data/process_prs_scores/'   # Processed results

# -----------------------------
# Define lists
# -----------------------------
trait_list = c('BMI', 'HEIGHT', 'DIABETES', 'METABOLIC')
pop_list = c("AFR", "AMR", "EAS", "EUR", "SAS")
cutoff_list = c("Pt_5e-08", "Pt_1e-07", "Pt_1e-06", "Pt_1e-05", 
                "Pt_0.0001", "Pt_0.001", "Pt_0.01", "Pt_0.1", 
                "Pt_0.2", "Pt_0.3", "Pt_0.5", "Pt_1")

array_list = c('global-screening-array-v.3X',
               'Axiom_JAPONICAX', 'Axiom_UKB_WCSGX', 'Axiom_PMRAX',
               'Axiom_PMDAX', 'cytosnp-850k-v1.2X',
               'infinium-omni2.5.v1.5X', 'infinium-omni5-v1.2X',
               'LPS0.5X', 'LPS0.75X', 'LPS1.0X', 'LPS1.25X', 
               'LPS1.5X', 'LPS2.0X')

# ----------------------------------------------------------
# Function: Compute percentile difference for WGS vs Array
# ----------------------------------------------------------
get_percentile_dif <- function(wgs, array, pop, trait, cutoff ){
  cols = names(wgs)[-c(1,2)]  # Remove FID, IID
  array_path = paste0(input_array_dir, array, "_", pop, "_", trait, ".all_score")
  arr = fread(array_path)

  # Extract PRS columns
  wgs2 = wgs[, ..cols]
  arr2 = arr[, ..cols]

  # Extract PRS values for the selected cutoff
  x = wgs2[[cutoff]]
  y = arr2[[cutoff]]

  # Compute ECDFs and convert raw scores to percentiles
  x1 = ecdf(x)
  y1 = ecdf(y)
  x = x1(x)  # WGS percentiles
  y = y1(y)  # Array percentiles

  # Calculate absolute percentile difference in %
  pct_dif = abs(x - y) * 100

  # Optional: array percentile using a specific column (3rd)
  arr_percentile <- ecdf(arr[[3]])
  y = arr_percentile(arr[[3]])

  # Return results as data frame
  tem = data.frame(wgs_pct = x, arr_pct = y, pct_dif = pct_dif, trait = trait)
  tem$array = array
  return(tem)
}

# ----------------------------------------------------------
# Function: Compute percentile differences for all arrays for one trait
# ----------------------------------------------------------
get_percentile_trait <- function(pop, array_list, trait, cutoff){
  # Load WGS PRS file for given population and trait
  wgs_path = paste0(input_wgs_dir, "WGS_", pop, "_", trait, ".all_score")
  wgs = fread(wgs_path)

  res = list()
  for(array in array_list){
    res[[array]] = get_percentile_dif(wgs, array, pop, trait, cutoff)
  }

  # Combine into single data frame
  df = as.data.frame(do.call(rbind, res))
  df$pop = pop
  return(df)
}

# ----------------------------------------------------------
# Function: Compute percentile differences for all traits in one population
# ----------------------------------------------------------
get_percentile_pop <- function(pop, array_list, trait_list, cutoff){
  res = list()
  for(trait in trait_list){
    res[[trait]] = get_percentile_trait(pop, array_list, trait, cutoff)
  }
  df = as.data.frame(do.call(rbind, res))
  df$pop = pop
  return(df)
}

# ----------------------------------------------------------
# Function: Compute percentile differences for all populations
# ----------------------------------------------------------
get_percentile_all <- function(pop_list, array_list, cutoff){
  res = list()
  for(pop in pop_list){
    res[[pop]] = get_percentile_pop(pop, array_list, trait_list, cutoff)
  }
  df = as.data.frame(do.call(rbind, res))
  return(df)
}

# ----------------------------------------------------------
# Main loop: Process all cutoffs and save results
# ----------------------------------------------------------
for(c in cutoff_list){
  message("Processing cutoff: ", c)
  x = get_percentile_all(pop_list, array_list, c)
  out_path = paste0(output_dir, c, '.csv')
  fwrite(x, out_path, sep = ',', row.names = FALSE)
}
