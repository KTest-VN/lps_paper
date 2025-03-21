
require(data.table)
require(scales)
require(ggplot2)

#trait_list = c('BMI', 'CAD', 'DIABETES', 'METABOLIC')
trait_list = c('BMI', 'HEIGHT', 'DIABETES', 'METABOLIC')
pop_list = c("AFR", "AMR", "EAS", "EUR", "SAS")
cutoff_list = c("Pt_5e-08", "Pt_1e-07", "Pt_1e-06", "Pt_1e-05", "Pt_0.0001", "Pt_0.001", "Pt_0.01", "Pt_0.1", "Pt_0.2", "Pt_0.3", "Pt_0.5", "Pt_1")

#array_list = c('Axiom_JAPONICAX', 'Axiom_PMDAX', 'Axiom_PMRAX', 'Axiom_UKB_WCSGX', 'cytosnp-850k-v1.2X', 'global-screening-array-v.3X', 'infinium-omni2.5.v1.5X' , 'infinium-omni5-v1.2X')

array_list = c('global-screening-array-v.3X',
	'Axiom_JAPONICAX',
	'Axiom_UKB_WCSGX',
	'Axiom_PMRAX',
	'Axiom_PMDAX',
	'cytosnp-850k-v1.2X',
	'infinium-omni2.5.v1.5X', 
	'infinium-omni5-v1.2X',
	'LPS0.5X',
	'LPS0.75X',
	'LPS1.0X',
	'LPS1.25X',
	'LPS1.5X',
	'LPS2.0X'
	)


get_percentile_dif <- function(wgs, array, pop, trait, cutoff ){
  #wgs_path = paste0("WGS_", pop, "_", trait, ".all_score" )
  #wgs = fread()
  cols = names(wgs)[-c(1,2)]
  array_path = paste0('raw_prs_scores/', array, "_", pop, "_", trait, ".all_score")
  arr = fread(array_path)
  wgs2 = wgs[, ..cols]
  arr2 = arr[,..cols]

  x = wgs2[[cutoff]] #rowMeans(wgs2)
  y = arr2[[cutoff]] #rowMeans(arr2)

  x1 = ecdf(x)
  y1 = ecdf(y)

  x = x1(x)
  y = y1(y)
  pct_dif = abs(x - y)*100

  arr_percentile <- ecdf(arr[[3]])
  y = arr_percentile(arr[[3]])

  tem = data.frame(wgs_pct = x, arr_pct = y, pct_dif = pct_dif, trait = trait)
  tem$array = array
  return(tem)
}


get_percentile_trait <- function(pop, array_list, trait, cutoff){

  wgs_path = paste0('raw_prs_scores/', "WGS_", pop, "_", trait, ".all_score" )
  wgs = fread(wgs_path)
  res = list()

  for(array in array_list){
      res[[array]] = get_percentile_dif(wgs, array, pop, trait, cutoff)
  }
  df = as.data.frame(do.call(rbind, res))
  df$pop = pop
  return(df)
}

get_percentile_pop <- function(pop, array_list, trait_list, cutoff){
  res = list()
  for(trait in trait_list){
      res[[trait]] = get_percentile_trait(pop, array_list, trait, cutoff)
  }
  df = as.data.frame(do.call(rbind, res))
  df$pop = pop
  return(df)
}


get_percentile_all <- function(pop_list, array_list, cutoff){
  res = list()
  for(pop in pop_list){
    df = get_percentile_pop(pop, array_list, trait_list, cutoff)
    res[[pop]] = get_percentile_pop(pop, array_list, trait_list, cutoff)
  }
  df = as.data.frame(do.call(rbind, res))
  return(df)
}

for(c in cutoff_list){
  x = get_percentile_all(pop_list, array_list, c)
  fwrite(x, paste0('process_prs_scores/', c, '.csv'), sep = ',', row.names = F)
} 
