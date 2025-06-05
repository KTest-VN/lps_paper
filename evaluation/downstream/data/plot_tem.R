

require(data.table)
require(scales)
require(ggplot2)

trait_list = c('BMI', 'CAD', 'DIABETES', 'METABOLIC')
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
  array_path = paste0('prs_scores/', array, "_", pop, "_", trait, ".all_score")
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

  wgs_path = paste0('prs_scores/', "WGS_", pop, "_", trait, ".all_score" )
  wgs = fread(wgs_path)
  res = list()

  for(array in array_list){
      res[[array]] = get_percentile_dif(wgs, array, pop, trait, cutoff)
  }
  df = as.data.frame(do.call(rbind, res))
  df$pop = pop
  return(df)
}



#x = get_percentile_trait('EUR', array_list, 'BMI', "Pt_5e-08")



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








# # x = get_percentile_pop('EUR', array_list, trait_list, "Pt_5e-08")

# array_oder = c('global-screening-array-v.3X',
# 	'Axiom_JAPONICA',
# 	'Axiom_UKB_WCSG',
# 	'Axiom_PMRA',
# 	'Axiom_PMDA',
# 	'cytosnp-850k-v1.2',
# 	'infinium-omni2.5.v1.5', 
# 	'infinium-omni5-v1.2',
# 	'LPS0.5',
# 	'LPS0.75',
# 	'LPS1.0',
# 	'LPS1.25',
# 	'LPS1.5',
# 	'LPS2.0'
# 	)


# rename_array <- function(df, array_oder){ 
#   df$array <- substring(df$array, 1, nchar(df$array) - 1)
#   df$array_rename <- factor(df$array, levels = array_oder)
#   return(df)
# }

# plot_5_pop <- function(pop_list, array_list, cutoff){
#   p = list()
#   for(pop in pop_list){
#     df = get_percentile_pop(pop, array_list, trait_list, cutoff)
#     df = rename_array(df, array_oder)
#     df$trait[df$trait == "HEIGHT"] = "Height" 
#     p[[pop]] = ggplot(data=df, aes(x = array_rename, y = pct_dif, fill = array_rename)) + geom_boxplot(outlier.shape = NA) + theme_light() + ylab("Percentile difference") + xlab("SNP array")  + facet_wrap(~ trait, nrow = 1) + theme(legend.position="none", axis.title.x = element_blank()) + guides(x = guide_axis(angle = 90)) + ggtitle(pop) +  scale_y_continuous(breaks=seq(0,100,5), limits = c(0,30) )
#   }
#     #p[[1]] = p[[1]] + theme(legend.position="none") + theme(axis.text.x = element_blank(), axis.ticks.x = element_blank(), axis.title.x = element_blank(), axis.title.y = element_blank()) 
#     p[[1]] = p[[1]] + theme(legend.position="none") + theme(axis.text.x = element_blank(), axis.ticks.x = element_blank(), axis.title.x = element_blank(), axis.title.y = element_blank())
#     p[[3]] = p[[3]] + theme(legend.position="none") + theme(axis.text.x = element_blank(), axis.ticks.x = element_blank(), axis.title.x = element_blank())
#     p[[2]] = p[[2]] + theme(legend.position="none") + theme(axis.text.x = element_blank(), axis.ticks.x = element_blank(), axis.title.x = element_blank(), axis.title.y = element_blank())
#     p[[4]] = p[[4]] + theme(legend.position="none") + theme(axis.text.x = element_blank(), axis.ticks.x = element_blank(), axis.title.x = element_blank(), axis.title.y = element_blank())
#     #p[[5]] = p[[5]] + theme(legend.position="none") + theme(axis.text.x = element_blank(), axis.ticks.x = element_blank(), axis.title.x = element_blank(), axis.title.y = element_blank())
#     p[[5]] = p[[5]] + theme(legend.position="none", axis.title.x = element_blank(), axis.title.y = element_blank())
    
#     library(patchwork)
#     m = wrap_plots(p, nrow = 5, plot_layout = "auto")
#     return(m)
# }


# m = plot_5_pop(pop_list, array_list, "Pt_5e-08")


# pdf(file= "test.pdf",  width=12, height=17)
# print(m)
# dev.off()















