#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

static char *input_path = "./input.txt";

#define ROW 0
#define COL 1
#define DIRS_CNT 4

static int dirs[DIRS_CNT][2] = {
    {-1,  0},
    { 0, -1},
    { 1,  0},
    { 0,  1}
};

#define LINES_CAP 128

char *lines[LINES_CAP];
size_t lines_cnt = 0;
size_t cols_cnt = 0;

bool is_low_point(row0, col0) {
    int col, row;
    int n = 0, p = lines[row0][col0];
    for (size_t i = 0; i < DIRS_CNT; ++i) {
        row = row0 + dirs[i][ROW];
        col = col0 + dirs[i][COL];
        if (0 <= row && row < lines_cnt) {
            if (0 <= col && col < cols_cnt) {
                n = lines[row][col];
                if (n <= p) return false;
            }
        }
    }
    return true;
}

void part_one(void) {
    FILE *f = fopen(input_path, "r");

    if (f == NULL) {
        fprintf(stderr, "[ERROR] Could not open file `%s`\n", input_path);
        exit(1);
    }

    size_t len = 0;
    ssize_t read;

    lines_cnt = 0;
    cols_cnt = 0;
    while ((read = getline(&lines[lines_cnt], &len, f)) != -1) {
        lines_cnt++;
        cols_cnt = read;
    }

    size_t answer = 0;
    for (size_t row = 0; row < lines_cnt; ++row) {
        for (size_t col = 0; col < cols_cnt; ++col) {
            if (is_low_point(row, col)) {
                answer += lines[row][col] - '0' + 1;
            }
        }
    }

    printf("Part One: %zu\n", answer);

    fclose(f);
}

int main() {
    part_one();
    return 0;
}