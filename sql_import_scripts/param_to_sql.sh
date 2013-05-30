#!/bin/bash

for f in *.param
do
    mysql -e "load data infile '"$f"' into table simsql.param_inp2 FIELDS TERMINATED BY '\n' (rings_equal, purple_or_green, J_betweenRings, EPR_or_specific, firstring_gx, firstring_gy, firstring_gz, secondring_gx, secondring_gy, secondring_gz, step_theta, step_phi, min_field, max_field, step_field, EPR_frequency, temperature, sigma, MF, MF_sigma, threshold, output_epr, output_summary)" -u test_user --password=test_password
done