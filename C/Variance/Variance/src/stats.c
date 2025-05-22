#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <math.h>

/* Global variables */
double totalGain = 0.0;
int compute_mean = 0;
int interval = 0;
const int multiplier = 65536;
const double VoltageConst = 2.048;


/* Static structure */
typedef struct {
    int count;
    double mean;
    double M2;
} Stats;


/* Structure inicialization */
void 
init_stats(Stats *s) {
    s->count = 0;
    s->mean = 0.0;
    s->M2 = 0.0;
}

/* Update of the statistics (only the ones we need to pass on: mean, count and variance) */
void 
update_stats(Stats *s, double x) {
    s->count++;
    double delta = x - s->mean;
    s->mean += delta / s->count;
    double delta2 = x - s->mean;
    s->M2 += delta * delta2;
}

/* Calculation of the mean value */
double 
get_mean(Stats *s) {
    return s->mean;
}

/* Calculation of the variance value */
double 
get_variance(Stats *s) {
    return s->count > 1 ? s->M2 / (s->count - 1) : 0.0;
}

/* Loading of the 32bit sample */
int32_t 
extract_raw_sample(FILE *input) {
    uint8_t bytes[4];
    if (fread(bytes, 1, 4, input) != 4) {
        return -9999999; // The EOF indicator (custom)
    }

    uint32_t raw = ((uint32_t)bytes[0]) |
                   ((uint32_t)bytes[1] << 8) |
                   ((uint32_t)bytes[2] << 16) |
                   ((uint32_t)bytes[3] << 24);

    // Extract bottom 17 bits from the 32bit integer
    int32_t sample = raw & 0x1FFFF; // Masks 17 bits (2^17)
    if (sample & (1 << 16)) {
        sample -= (1 << 17);
    }

    return sample;
}

/* Conversion to volts */
double 
convert_sample(int32_t raw_sample) {
    double factor = VoltageConst / 65536.0;
    return raw_sample * factor * pow(10, -totalGain/20);
}


/* Main code */
int 
main(int argc, char *argv[]) {
    int counter = 0;
    int32_t raw_sample;

    // Making sure that correct arguments were passed
    if (argc != 4) {
        fprintf(stderr, "Usage: %s <interval N> <statistic: mean|var> <totalGain>\n", argv[0]);
        return 1;
    }

    // Getting the N interval
    int interval = atoi(argv[1]);
    if (interval <= 0) {
        fprintf(stderr, "Interval must be a whole number!\n");
        return 1;
    }

    // Getting the Gain value from bash (PreGain + Gain)
    totalGain = atof(argv[3]);

    // Getting the setting for further calculation (Mean/Variance)
    int compute_mean = 0;
    if (strcmp(argv[2], "mean") == 0) {
        compute_mean = 1;
    } else if (strcmp(argv[2], "var") != 0) {
        fprintf(stderr, "Statistic must be 'mean' or 'var'\n");
        return 1;
    }

    // Creating structure + inicialization of its values
    Stats stats;
    init_stats(&stats);

    // Main loop (goes on until extract function is at the end of file)
    while ((raw_sample = extract_raw_sample(stdin)) != -9999999) {
        double physical_value = convert_sample(raw_sample);

        update_stats(&stats, physical_value);
        counter++; // Increasing the "n" value

        if (counter == interval) {
            if (compute_mean)
                printf("%.10e\n", get_mean(&stats));  // Mean Output
            else
                printf("%.10e\n", get_variance(&stats));  // Variance output

            init_stats(&stats);
            counter = 0;
        }
    }

    return 0;
}

