require(data.table)
 

####################################
###Merging transposed biota files###

#depth profile
#Baltic
bio_dp1 <- fread("Input/Baltic/transposed_data_from_harmonized_biota_profiles_Baltic_200803.txt")
bio_dp1$emd_region <- "Baltic"     
#Black Sea
bio_dp2 <- fread("Input/Black/transposed_data_from_BLS_Harmonized_Contaminants_Biota.txt")
bio_dp2$emd_region <- "Black"     
#Mediterranean Sea
bio_dp3 <- fread("Input/Mediterranean/transposed_data_from_Contaminant_MED_profiles_biota.txt")
bio_dp3$emd_region <- "Mediterranean"     

#Merge depth profile tables
bio_dpAll <- rbindlist(list(bio_dp1,bio_dp2,bio_dp3), use.names = TRUE, fill=TRUE)
#add id
id <- seq_len(nrow(bio_dpAll))
bio_dpAll <- cbind(id, bio_dpAll)
#Add value_txt - not needed for now
#bio_dpAll$Value_txt <- bio_dpAll$Value

#Write output table
write.table(bio_dpAll, file = "Results/bio_dpAll.txt", quote=FALSE, sep = "\t",
            row.names = FALSE, col.names = TRUE, na="")

#time series
#Atlantic
bio_ts1 <- fread("Input/Atlantic/transposed_data_from_harmonized_Biota_time_series.txt")
bio_ts1$emd_region <- "Atlantic"     
#Baltic
bio_ts2 <- fread("Input/Baltic/transposed_data_from_harmonized_biota_timeseries_Baltic_200623.txt")
bio_ts2$emd_region <- "Baltic"  
#Mediterranean
bio_ts3 <- fread("Input/Mediterranean/transposed_data_from_Contaminant_MED_timeseries_biota.txt")
bio_ts3$emd_region <- "Mediterranean"  
#North Sea
bio_ts4 <- fread("Input/NorthSea/transposed_data_from_data_from_harmonized_Harmonized_2019-2020_biota_data.txt")
bio_ts4$emd_region <- "NorthSea"

#Merge time series tables
bio_tsAll <- rbindlist(list(bio_ts1,bio_ts2,bio_ts3,bio_ts4), use.names = TRUE, fill=TRUE)
#Add id
id <- seq_len(nrow(bio_tsAll))
bio_tsAll <- cbind(id, bio_tsAll)
#Add value_txt - not needed for now
#bio_tsAll$Value_txt <- bio_tsAll$Value


#write output table
write.table(bio_tsAll, file = "Results/bio_tsAll.txt", quote=FALSE, sep = "\t",
            row.names = FALSE, col.names = TRUE, na="")


#######################################
###Merging transposed sediment files###

#depth profile
#Arctic
sed_dp1 <- fread("Input/Arctic/transposed_data_from_harmonized_sediment_depth_profiles_v3.txt")
sed_dp1$emd_region <- "Arctic"  
#Atlantic
sed_dp2 <- fread("Input/Atlantic/transposed_data_from_harmonized_sediment_depth_profiles.txt")
sed_dp2$emd_region <- "Atlantic"  
#Baltic
sed_dp3 <- fread("Input/Baltic/transposed_data_from_harmonized_sediment_profiles_Baltic_200806.txt")
sed_dp3$emd_region <- "Baltic"  
sed_dp3_upper10 <- fread("Input/Baltic/transposed_data_from_range001_harmonized_sediment_profiles_Baltic_200806.txt")
sed_dp3_upper10$emd_region <- "Baltic"  
#Black 
sed_dp4 <- fread("Input/Black/transposed_data_from_BLS_Harmonized_Contaminants_Sediment_v2.txt")
sed_dp4$emd_region <- "Black"  
#Mediterranean
sed_dp5 <- fread("Input/Mediterranean/transposed_data_from_Contaminant_MED_profiles_sediment.txt")
sed_dp5$emd_region <- "Mediterranean"  

#Merge depth profile tables
sed_dpAll <- rbindlist(list(sed_dp1,sed_dp2,sed_dp3,sed_dp4,sed_dp5), use.names = TRUE, fill=TRUE)
## Add id
id <- seq_len(nrow(sed_dpAll))
sed_dpAll <- cbind(id, sed_dpAll)
#Add value_txt
sed_dpAll$Value_txt <- sed_dpAll$Value

#write output table
write.table(sed_dpAll, file = "Results/sed_dpAll.txt", quote=FALSE, sep = "\t",
            row.names = FALSE, col.names = TRUE, na="")


#time series
#Atlantic
sed_ts1 <- fread("Input/Atlantic/transposed_data_from_harmonized_sediment_time_series.txt")
sed_ts1$emd_region <- "Atlantic"  
#Mediterranean
sed_ts2 <- fread("Input/Mediterranean/transposed_data_from_Contaminant_MED_timeseries_sediment.txt")
sed_ts2$emd_region <- "Mediterranean"  

#Merge time series tables
sed_tsAll <- rbindlist(list(sed_ts1,sed_ts2), use.names = TRUE, fill=TRUE)
#Add id
id <- seq_len(nrow(sed_tsAll))
sed_tsAll <- cbind(id, sed_tsAll)
#Add value_txt
sed_tsAll$Value_txt <- sed_tsAll$Value


#write output table
write.table(sed_tsAll, file = "Results/sed_tsAll.txt", quote=FALSE, sep = "\t",
            row.names = FALSE, col.names = TRUE, na="")

##################################
###Merge transposed water files###

#depth profile
#Arctic
wat_dp1 <- fread("Input/Arctic/transposed_data_from_harmonized_ocean_depth_profiles.txt")
wat_dp1$emd_region <- "Arctic"  
#Atlantic
wat_dp2 <- fread("Input/Atlantic/transposed_data_from_harmonized_ocean_depth_profiles_cleaned.txt")
wat_dp2$emd_region <- "Atlantic"  
#Baltic
wat_dp3 <- fread("Input/Baltic/transposed_data_from_harmonized_water_profiles_Baltic_200709.txt")
wat_dp3$emd_region <- "Baltic"  
#Black
wat_dp4 <- fread("Input/Black/transposed_data_from_BLS_Harmonized_Contaminants_Water.txt")
wat_dp4$emd_region <- "Black"  
#Mediterranean
wat_dp5 <- fread("Input/Mediterranean/transposed_data_from_Contaminant_MED_profiles_water.txt")
wat_dp5$emd_region <- "Mediterranean"  

#Merge depth profile tables
wat_dpAll <- rbindlist(list(wat_dp1,wat_dp2,wat_dp3,wat_dp4,wat_dp5), use.names = TRUE, fill=TRUE)
#Add id
id <- seq_len(nrow(wat_dpAll))
wat_dpAll <- cbind(id, wat_dpAll)
#Add value_txt
wat_dpAll$Value_txt <- wat_dpAll$Value

#write output table
write.table(wat_dpAll, file = "Results/wat_dpAll.txt", quote=FALSE, sep = "\t",
            row.names = FALSE, col.names = TRUE, na="")


#time series
#Black
wat_ts1 <- fread("Input/Black/transposed_data_from_BLS_harmonized_time_series_Contaminants_Water.txt")
wat_ts1$emd_region <- "Black"  
#Mediterranean
wat_ts2 <- fread("Input/Mediterranean/transposed_data_from_Contaminant_MED_timeseries_water.txt")
wat_ts2$emd_region <- "Mediterranean"  

#Merge time series tables
wat_tsAll <- rbindlist(list(wat_ts1,wat_ts2), use.names = TRUE, fill=TRUE)
#Add id
id <- seq_len(nrow(wat_tsAll))
wat_tsAll <- cbind(id, wat_tsAll)
#Add value_txt
wat_tsAll$Value_txt <- wat_tsAll$Value

#write output table
write.table(wat_tsAll, file = "Results/wat_tsAll.txt", quote=FALSE, sep = "\t",
            row.names = FALSE, col.names = TRUE, na="")

###Diverse
#head(dtAll_ts, n=10)
#tail(dtAll_ts, n=10)
#str(td1_ts)
#summary(td1_ts)
#colnames(dt1_ts)
#colnames(dt2_ts)
