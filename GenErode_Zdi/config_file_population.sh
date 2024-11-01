#!/bin/bash

# this script is meant to automate the process of creating and populating the XXX_historical_samples.txt and XXX_modern_samples.txt files within your GenErode_XXX/config directory.
# this should be run in your GenErode_XXX directory
# make sure lines 9 and 10 are edited to suit your species, and that your 1st and 2nd sequencing run directories are within the same parent directory
	# i.e. pire_parupeneus_barberinus_lcwgs/1st_sequencing_run and pire_parupeneus_barberinus_lcwgs/2nd_sequencing_run  

# Define variables
species_code="Zdi"  # Replace XXX with the actual species code, ex. "Pbb"
species_name="zenarchopterus_dispar"  # Replace with the actual species name, ex. "parupeneus_barberinus"

# Define directories
base_dir="/archive/carpenterlab/pire/pire_${species_name}_lcwgs"
first_seq_dir="$base_dir/1st_sequencing_run/fq_raw"		
	# for this to work, 1st_sequencing_run needs to be within the same directory as 2nd_sequencing_run. 
	# If it is not, you need to copy at least (1st_sequencing_run/fq_raw) to be within the same (pire_species_name_lcwgs) directory.
second_seq_dir="$base_dir/2nd_sequencing_run/fq_raw"
historical_dir="$base_dir/GenErode_${species_code}/historical"	# needs to be populated with both 1st and 2nd sequencing run fq.gz files
modern_dir="$base_dir/GenErode_${species_code}/modern"		# needs to be populated with both 1st and 2nd sequencing run fq.gz files
config_dir="$base_dir/GenErode_${species_code}/config"	

# Define output files: creating the files in the proper directory
historical_samples_file="${config_dir}/${species_code}_historical_samples.txt"
modern_samples_file="${config_dir}/${species_code}_modern_samples.txt"

# Write headers to the output files
echo "samplename_index_lane readgroup_id readgroup_platform path_to_R1_fastq_file path_to_R2_fastq_file" > "$historical_samples_file"
echo "samplename_index_lane readgroup_id readgroup_platform path_to_R1_fastq_file path_to_R2_fastq_file" > "$modern_samples_file"

# Extract indices, lanes, and read group IDs
	# these will be the same for all individuals within each sequencing run, so we can define them as a single variable
index_1st=$(ls "$first_seq_dir"/*fq.gz | head -n 1 | xargs basename | cut -c14-16)
index_2nd=$(ls "$second_seq_dir"/*fq.gz | head -n 1 | xargs basename | cut -c14-16)
	# this prints the name of the first fq.gz file within (X_sequencing_run/fq_raw) and isolates the 14th to 16th characters, which contain the index
	# xargs basename makes sure only the fq.gz file name prints, not the path to get there since character positioning matters
	# output should look like: "Ex1"

lane_1st=$(cat "$first_seq_dir"/origFileNames.txt | head -n 1 | cut -c40-41)
lane_2nd=$(cat "$second_seq_dir"/origFileNames.txt | head -n 1 | cut -c40-41)
	# this opens the file "origFileNames.txt" within each sequencing run, prints the first line, and isolates characters 40-41
	# output should look like: "L3"

readgroup_id_1st=$(gunzip -c "$first_seq_dir"/*fq.gz | head -n 1 | cut -c14-24)
readgroup_id_2nd=$(gunzip -c "$second_seq_dir"/*fq.gz | head -n 1 | cut -c14-24)
	# this unzips the first fq.gz file within each directory, prints the first line, and isolates characters 14-24
	# output should look like: "2277W2LT4:3"

# Get sample names from both sequencing runs
	# this prints the name of every fq.gz file within (X_sequencing_run/fq_raw) that is either Albatross or Contemporary and isolates the first 12 characters
	# it also isolates the file name, removing the path, and removes duplicates
	# the first 12 characters will look like: "Pbb-AGal_001", but we need to remove -_ to follow the proper format
	# output should look like: "PbbAGal001"
historical_samples_1st=$(ls "$first_seq_dir"/*fq.gz | xargs -n 1 basename | cut -c1-12 | uniq | sed 's/[-_]//g' | grep 'A')
historical_samples_2nd=$(ls "$second_seq_dir"/*fq.gz | xargs -n 1 basename | cut -c1-12 | uniq | sed 's/[-_]//g' | grep 'A')
modern_samples_1st=$(ls "$first_seq_dir"/*fq.gz | xargs -n 1 basename | cut -c1-12 | uniq | sed 's/[-_]//g' | grep 'C')
modern_samples_2nd=$(ls "$second_seq_dir"/*fq.gz | xargs -n 1 basename | cut -c1-12 | uniq | sed 's/[-_]//g' | grep 'C')

# Define a function to format sample names for searching
	# in order to properly match up each r1 and r2 path with the corresponding sample, we have to temporarily transform the samplename
	# this command transforms sample names from "PbbAGal001" to just the number "001" for searching historical/modern directories
format_sample_for_search() {
  echo "$1" | sed -E 's/.*([0-9]{3})$/\1/'
}

# Process historical samples from the 1st sequencing run
	# for every sample saved from above, isolate the last 3 numbers and search the historical/modern directories for the corresponding r1 and r2 files
	# this will print the entire path, but we only want "historical/filename" so we need to prevent a portion of the pathway from printing
	# additionally, as each path is being searched for every sample, a message will print displaying this information, as well as the transformed samplename to help identify any errors
for sample in $historical_samples_1st; do
  formatted_sample=$(format_sample_for_search "$sample")
  echo "Searching for R1 and R2 for historical sample (1st run): $sample"
  echo "Formatted sample name for search: $formatted_sample"
  
  r1_path=$(ls -1 "$historical_dir"/*1.1.fq.gz | grep "$formatted_sample" | sed "s|$base_dir/GenErode_${species_code}/||")
  r2_path=$(ls -1 "$historical_dir"/*1.2.fq.gz | grep "$formatted_sample" | sed "s|$base_dir/GenErode_${species_code}/||")
  
  echo "r1_path: $r1_path"
  echo "r2_path: $r2_path"
 
 	# if there is a problem with finding the correct paths, this message will notify you of the issue:
  if [[ -z "$r1_path" || -z "$r2_path" ]]; then
    echo "Error: Missing R1 or R2 file for sample $sample"
    echo "r1_path: $r1_path"
    echo "r2_path: $r2_path"
    
    # if there are no problems, each sample and it's corresponding information will be appended to the proper files 
  else
    echo "${sample}_${index_1st}_${lane_1st} $readgroup_id_1st illumina $r1_path $r2_path" >> "$historical_samples_file"
  fi
done

# Process historical samples from the 2nd sequencing run
for sample in $historical_samples_2nd; do
  formatted_sample=$(format_sample_for_search "$sample")
  echo "Searching for R1 and R2 for historical sample (2nd run): $sample"
  echo "Formatted sample name for search: $formatted_sample"
  
  r1_path=$(ls -1 "$historical_dir"/*2.1.fq.gz | grep "$formatted_sample" | sed "s|$base_dir/GenErode_${species_code}/||")
  r2_path=$(ls -1 "$historical_dir"/*2.2.fq.gz | grep "$formatted_sample" | sed "s|$base_dir/GenErode_${species_code}/||")
  
  echo "r1_path: $r1_path"
  echo "r2_path: $r2_path"
  
  if [[ -z "$r1_path" || -z "$r2_path" ]]; then
    echo "Error: Missing R1 or R2 file for sample $sample"
    echo "r1_path: $r1_path"
    echo "r2_path: $r2_path"
  else
    echo "${sample}_${index_2nd}_${lane_2nd} $readgroup_id_2nd illumina $r1_path $r2_path" >> "$historical_samples_file"
  fi
done

# Process modern samples from the 1st sequencing run
for sample in $modern_samples_1st; do
  formatted_sample=$(format_sample_for_search "$sample")
  echo "Searching for R1 and R2 for modern sample (1st run): $sample"
  echo "Formatted sample name for search: $formatted_sample"
  
  r1_path=$(ls -1 "$modern_dir"/*1.1.fq.gz | grep "$formatted_sample" | sed "s|$base_dir/GenErode_${species_code}/||")
  r2_path=$(ls -1 "$modern_dir"/*1.2.fq.gz | grep "$formatted_sample" | sed "s|$base_dir/GenErode_${species_code}/||")
  
  echo "r1_path: $r1_path"
  echo "r2_path: $r2_path"
  
  if [[ -z "$r1_path" || -z "$r2_path" ]]; then
    echo "Error: Missing R1 or R2 file for sample $sample"
    echo "r1_path: $r1_path"
    echo "r2_path: $r2_path"
  else
    echo "${sample}_${index_1st}_${lane_1st} $readgroup_id_1st illumina $r1_path $r2_path" >> "$modern_samples_file"
  fi
done

# Process modern samples from the 2nd sequencing run
for sample in $modern_samples_2nd; do
  formatted_sample=$(format_sample_for_search "$sample")
  echo "Searching for R1 and R2 for modern sample (2nd run): $sample"
  echo "Formatted sample name for search: $formatted_sample"
  
  r1_path=$(ls -1 "$modern_dir"/*2.1.fq.gz | grep "$formatted_sample" | sed "s|$base_dir/GenErode_${species_code}/||")
  r2_path=$(ls -1 "$modern_dir"/*2.2.fq.gz | grep "$formatted_sample" | sed "s|$base_dir/GenErode_${species_code}/||")
  
  echo "r1_path: $r1_path"
  echo "r2_path: $r2_path"
  
  if [[ -z "$r1_path" || -z "$r2_path" ]]; then
    echo "Error: Missing R1 or R2 file for sample $sample"
    echo "r1_path: $r1_path"
    echo "r2_path: $r2_path"
  else
    echo "${sample}_${index_2nd}_${lane_2nd} $readgroup_id_2nd illumina $r1_path $r2_path" >> "$modern_samples_file"
  fi
done
