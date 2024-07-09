library(data.table)
library(dplyr)
library(R.utils)

 
#EMD 2024 transposed data provided in https://drive.google.com/drive/u/0/folders/1tp1gWdOewq2Qz3dOeXotKevdY-ErQ1Gz
#Note that North Sea is missing. The reason is problems identified at EMD
####################################
###Merging transposed biota files###

#depth profile
#Baltic
bio_dp1 <- fread("Input/2024/transposed_data_from_Contaminant_BalticSea_profiles_biota_2024.txt", check.names = TRUE)
bio_dp1$emd_region <- "Baltic"     
#Black Sea
bio_dp2 <- fread("Input/2024/transposed_data_from_Contaminant_BlackSea_profiles_biota_2024.txt", check.names = TRUE)
bio_dp2$emd_region <- "Black"     
#Mediterranean Sea
bio_dp3 <- fread("Input/2024/transposed_data_from_Contaminant_Med_profiles_biota_2024.txt", check.names = TRUE)
bio_dp3$emd_region <- "Mediterranean"     

#Merge depth profile tables
bio_dpAll <- rbindlist(list(bio_dp1,bio_dp2,bio_dp3), use.names = TRUE, fill=TRUE)

# #Compare headers with preferred import header
# navne <- colnames(bio_dpAll)
# navneref <- c("Cruise","Station","DateTime","Longitude","Latitude","LOCAL_CDI_ID","EDMO_code","BotDepth","InstrumentInfo","References","Datum","WaterDepth","DepthReference","MinInstrumentDepth","MaxInstrumentDepth","Instrument_GearType","StationName","Originator","ProjectName","EDMEDreferences","AccessRestriction","CDI_record_id","SampleIdentifier","SubsampleIdentifier","ODV_internal_sample_number","Depth","Depth_QV","Value","Value_QV","Units","P01_conceptid","P01_preflabel","S06_preflabel","S07_preflabel","S27_preflabel","S27_altlabel","CAS","S02_preflabel","S26_preflabel","S25_preflabel","S03_preflabel","S04_preflabel","S05_preflabel","S21_preflabel","emd_region")
# #order <- order(navne)
# #orderref <- order(navneref)
# #mismatch_indices <- which(order != orderref)
# #mismatch_indices
# comparison <- data.frame(
#   Item = navne,
#   Itemref = navneref
# #  Order_Item = order,
# #  Order_Itemref = orderref
#   )
# # check comparison listing, are they ordered correctly for renaming?
# #print(comparison)

#Rename columns for import into DB - used for MAR001
colnames(bio_dpAll) <- c("Cruise","Station","DateTime","Longitude","Latitude","LOCAL_CDI_ID","EDMO_code","BotDepth","InstrumentInfo","References","Datum","WaterDepth","DepthReference","MinInstrumentDepth","MaxInstrumentDepth","Instrument_GearType","StationName","Originator","ProjectName","EDMEDreferences","AccessRestriction","CDI_record_id","SampleIdentifier","SubsampleIdentifier","ODV_internal_sample_number","Depth","Depth_QV","Value","Value_QV","Units","P01_conceptid","P01_preflabel","S06_preflabel","S07_preflabel","S27_preflabel","S27_altlabel","CAS","S02_preflabel","S26_preflabel","S25_preflabel","S03_preflabel","S04_preflabel","S05_preflabel","S21_preflabel","emd_region")

#add id
id <- seq_len(nrow(bio_dpAll))
bio_dpAll <- cbind(id, bio_dpAll)
rm(id)

#Add a column with the 180 degree longitude
bio_dpAll <- bio_dpAll[,Longitude_180 := ifelse(`Longitude` >= 180, `Longitude` - 360, `Longitude`)]

#Write output table
write.table(bio_dpAll, file = "Results/EMD_bio_dpAll.txt", quote=FALSE, sep = "\t",
            row.names = FALSE, col.names = TRUE, na="")
#gzip("Results/EMD_bio_dpAll.txt")

# Calculate the maximum length of each field - useful when importing to SQL DB
# max_lengths <- sapply(bio_tsAll, function(column) {
#   # Remove NA values
#   non_na_values <- na.omit(column)
#   # If all values are NA, return NA
#   if (length(non_na_values) == 0) {
#     return(NA)
#   } else {
#     return(max(nchar(as.character(non_na_values))))
#   }
})
#print(max_lengths)

#time series
#Atlantic
bio_ts1 <- fread("Input/2024/transposed_data_from_Contaminant_Atlantic_timeseries_biota_2024.txt", check.names = TRUE)
bio_ts1$emd_region <- "Atlantic"     
#Baltic
bio_ts2 <- fread("Input/2024/transposed_data_from_Contaminant_BalticSea_timeseries_biota_2024.txt", check.names = TRUE)
bio_ts2$emd_region <- "Baltic"  
#Mediterranean
bio_ts3 <- fread("Input/2024/transposed_data_from_Contaminant_Med_timeseries_biota_2024.txt", check.names = TRUE)
bio_ts3$emd_region <- "Mediterranean"  
#North Sea
#bio_ts4 <- fread("Input/2021/transposed_data_from_NorthSea_biota_from_harmonized_time_series w_profiles_v4.txt")
#bio_ts4$emd_region <- "NorthSea"

#Merge time series tables
bio_tsAll <- rbindlist(list(bio_ts1,bio_ts2,bio_ts3), use.names = TRUE, fill=TRUE)

# #Compare headers with preferred import header
# navne <- colnames(bio_tsAll)
# navneref <- c("Cruise","Station","DateTime","Longitude","Latitude","LOCAL_CDI_ID","EDMO_code","BotDepth","InstrumentInfo","References","Datum","WaterDepth","DepthReference","MinInstrumentDepth","MaxInstrumentDepth","Instrument_GearType","StationName","Originator","ProjectName","EDMEDreferences","AccessRestriction","CDI_record_id","SampleIdentifier","SubsampleIdentifier","ODV_internal_sample_number","Time","Time_QV","Value","Value_QV","Units","P01_conceptid","P01_preflabel","S06_preflabel","S07_preflabel","S27_preflabel","S27_altlabel","CAS","S02_preflabel","S26_preflabel","S25_preflabel","S03_preflabel","S04_preflabel","S05_preflabel","S21_preflabel","emd_region")
# #order <- order(navne)
# #orderref <- order(navneref)
# #mismatch_indices <- which(order != orderref)
#mismatch_indices
# comparison <- data.frame(
#   Item = navne,
#   Itemref = navneref
# #  Order_Item = order,
# #  Order_Itemref = orderref
#   )
# # check comparison listing, are they ordered correctly for renaming?
# #print(comparison)

#Rename columns for import into DB - used for MAR001
colnames(bio_tsAll) <- c("Cruise","Station","DateTime","Longitude","Latitude","LOCAL_CDI_ID","EDMO_code","BotDepth","InstrumentInfo","References","Datum","WaterDepth","DepthReference","MinInstrumentDepth","MaxInstrumentDepth","Instrument_GearType","StationName","Originator","ProjectName","EDMEDreferences","AccessRestriction","CDI_record_id","SampleIdentifier","SubsampleIdentifier","ODV_internal_sample_number","Time","Time_QV","Value","Value_QV","Units","P01_conceptid","P01_preflabel","S06_preflabel","S07_preflabel","S27_preflabel","S27_altlabel","CAS","S02_preflabel","S26_preflabel","S25_preflabel","S03_preflabel","S04_preflabel","S05_preflabel","S21_preflabel","emd_region")

#Add id
id <- seq_len(nrow(bio_tsAll))
bio_tsAll <- cbind(id, bio_tsAll)
rm(id)

#Add a column with the 180 degree longitude
bio_tsAll <- bio_tsAll[,Longitude_180 := ifelse(`Longitude` >= 180, `Longitude` - 360, `Longitude`)]

#write output table
write.table(bio_tsAll, file = "Results/EMD_bio_tsAll.txt", quote=FALSE, sep = "\t",
            row.names = FALSE, col.names = TRUE, na="")
#gzip("Results/EMD_bio_tsAll.txt")

# Calculate the maximum length of each field - useful when importing to SQL DB
#max_lengths <- sapply(bio_tsAll, function(column) max(nchar(as.character(column))))
# max_lengths <- sapply(bio_tsAll, function(column) {
#   # Remove NA values
#   non_na_values <- na.omit(column)
#   # If all values are NA, return NA
#   if (length(non_na_values) == 0) {
#     return(NA)
#   } else {
#     return(max(nchar(as.character(non_na_values))))
#   }
# })
#print(max_lengths)


#######################################
###Merging transposed sediment files###

#depth profile
#Arctic
sed_dp1 <- fread("input/2024/transposed_data_from_Contaminant_Arctic_profiles_sediment_2024.txt", check.names = TRUE)
sed_dp1$emd_region <- "Arctic"  
#Atlantic
sed_dp2 <- fread("input/2024/transposed_data_from_Contaminant_Atlantic_profiles_sediment_2024.txt", check.names = TRUE)
sed_dp2$emd_region <- "Atlantic"  
#Rename odd column name to fit others
setnames(sed_dp2, "Depth.below.seabed..m.", "DepBelowBed..m.")
#Baltic
sed_dp3 <- fread("input/2024/transposed_data_from_Contaminant_BalticSea_profiles_sediment_2024.txt", check.names = TRUE)
sed_dp3$emd_region <- "Baltic"  
#Black 
sed_dp4 <- fread("input/2024/transposed_data_from_Contaminant_BlackSea_profiles_sediment_2024.txt", check.names = TRUE)
sed_dp4$emd_region <- "Black"  
#Mediterranean
sed_dp5 <- fread("input/2024/transposed_data_from_Contaminant_Med_profiles_sediment_2024.txt", check.names = TRUE)
sed_dp5$emd_region <- "Mediterranean"  

#Merge depth profile tables
sed_dpAll <- rbindlist(list(sed_dp1,sed_dp2,sed_dp3,sed_dp4,sed_dp5), use.names = TRUE, fill=TRUE)
## Add id
id <- seq_len(nrow(sed_dpAll))
sed_dpAll <- cbind(id, sed_dpAll)
rm(id)

#Add a column with the 180 degree longitude
sed_dpAll <- sed_dpAll[,Longitude_180 := ifelse(`Longitude..degrees_east.` >= 180, `Longitude..degrees_east.` - 360, `Longitude..degrees_east.`)]
#write output table
write.table(sed_dpAll, file = "Results/EMD_sed_dpAll.txt", quote=FALSE, sep = "\t",
            row.names = FALSE, col.names = TRUE, na="")
gzip("Results/EMD_sed_dpAll.txt")

#time series
#Atlantic
sed_ts1 <- fread("Input/2024/transposed_data_from_Contaminant_Atlantic_timeseries_sediment_2024.txt", check.names = TRUE)
sed_ts1$emd_region <- "Atlantic"  
#Mediterranean
sed_ts2 <- fread("Input/2024/transposed_data_from_Contaminant_Med_timeseries_sediment_2024.txt", check.names = TRUE)
sed_ts2$emd_region <- "Mediterranean"  

#Merge time series tables
sed_tsAll <- rbindlist(list(sed_ts1,sed_ts2), use.names = TRUE, fill=TRUE)
#Add id
id <- seq_len(nrow(sed_tsAll))
sed_tsAll <- cbind(id, sed_tsAll)
rm(id)

#Add a column with the 180 degree longitude
#Below a version that rounds the Longitude to 6 decimal places
#sed_tsAll <- sed_tsAll[,Longitude_180 := ifelse(`Longitude..degrees_east.` >= 180, format(round(`Longitude..degrees_east.` - 360, 6), nsmall = 6), format(round(`Longitude..degrees_east.`, 6), nsmall = 6))]
sed_tsAll <- sed_tsAll[,Longitude_180 := ifelse(`Longitude..degrees_east.` >= 180, `Longitude..degrees_east.` - 360, `Longitude..degrees_east.`)]

#write output table
write.table(sed_tsAll, file = "Results/EMD_sed_tsAll.txt", quote=FALSE, sep = "\t",
            row.names = FALSE, col.names = TRUE, na="")
gzip("Results/EMD_sed_tsAll.txt")

##################################
###Merge transposed water files###

#depth profile
#Arctic
wat_dp1 <- fread("Input/2024/transposed_data_from_Contaminant_Arctic_profiles_water_2024.txt", check.names = TRUE)
wat_dp1$emd_region <- "Arctic"  
#Rename odd column name to fit others
setnames(wat_dp1, "Depth..m.", "DepBelowSurf..m.")
#Atlantic
wat_dp2 <- fread("Input/2024/transposed_data_from_Contaminant_Atlantic_profiles_water_2024.txt", check.names = TRUE)
wat_dp2$emd_region <- "Atlantic" 
#Baltic
wat_dp3 <- fread("Input/2024/transposed_data_from_Contaminant_BalticSea_profiles_water_2024.txt", check.names = TRUE)
wat_dp3$emd_region <- "Baltic"  
#Black
wat_dp4 <- fread("Input/2024/transposed_data_from_Contaminant_BlackSea_profiles_water_2024.txt", check.names = TRUE)
wat_dp4$emd_region <- "Black"  
#Mediterranean
wat_dp5 <- fread("Input/2024/transposed_data_from_Contaminant_Med_profiles_water_2024.txt", check.names = TRUE)
wat_dp5$emd_region <- "Mediterranean"  

#Merge depth profile tables
wat_dpAll <- rbindlist(list(wat_dp1,wat_dp2,wat_dp3,wat_dp4,wat_dp5), use.names = TRUE, fill=TRUE)
#Add id
id <- seq_len(nrow(wat_dpAll))
wat_dpAll <- cbind(id, wat_dpAll)

#Add a column with the 180 degree longitude
wat_dpAll <- wat_dpAll[,Longitude_180 := ifelse(`Longitude..degrees_east.` >= 180, `Longitude..degrees_east.` - 360, `Longitude..degrees_east.`)]

#write output table
write.table(wat_dpAll, file = "Results/EMD_wat_dpAll.txt", quote=FALSE, sep = "\t",
            row.names = FALSE, col.names = TRUE, na="")
gzip("Results/EMD_wat_dpAll.txt")

#time series
#Black
## No timeseries water data from Black sea in 2022
# wat_ts1 <- fread("Input/Black/transposed_data_from_BLS_harmonized_time_series_Contaminants_Water.txt", check.names = TRUE)
# wat_ts1$emd_region <- "Black"  
#Mediterranean
wat_ts2 <- fread("Input/2024/transposed_data_from_Contaminant_Med_timeseries_water_2024.txt", check.names = TRUE)
wat_ts2$emd_region <- "Mediterranean"  

#Merge time series tables
wat_tsAll <- wat_ts2
##wat_tsAll <- rbindlist(list(wat_ts1,wat_ts2), use.names = TRUE, fill=TRUE)
#Add id
id <- seq_len(nrow(wat_tsAll))
wat_tsAll <- cbind(id, wat_tsAll)

#Add a column with the 180 degree longitude
wat_tsAll <- wat_tsAll[,Longitude_180 := ifelse(`Longitude..degrees_east.` >= 180, `Longitude..degrees_east.` - 360, `Longitude..degrees_east.`)]

#write output table
write.table(wat_tsAll, file = "Results/EMD_wat_tsAll.txt", quote=FALSE, sep = "\t",
            row.names = FALSE, col.names = TRUE, na="")
gzip("Results/EMD_wat_tsAll.txt")

###Diverse
#head(dtAll_ts, n=10)
#tail(dtAll_ts, n=10)
#str(td1_ts)
#summary(td1_ts)
#colnames(dt1_ts)
#colnames(dt2_ts)
