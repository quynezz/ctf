
#include <stdio.h>

unsigned int out_put_0 = 6442450944;
unsigned int out_put_1 = 192096208;
unsigned int out_put_2 = 111120240;
unsigned int out_put_3 = 286156338;

void input_func(unsigned long long *x, unsigned long long *y,
                unsigned long long *z,
                unsigned long long *t) {
    printf("To avoid being invaded, give me x y z t (Space separated): ");
    scanf("%llu %llu %llu %llu", x, y, z, t);
}

int math_func(unsigned long long x, unsigned long long y,
              unsigned long long z,
              unsigned long long t) {
    

    return 1;
}

void graduate() {
    unsigned long long x, y, z, t;
    input_func(&x, &y, &z, &t);
    if (math_func(x, y, z, t)) {
        printf("Excellent, treat yourself to some pennywort.!\n");
        printf("Here's your pennywort: \n");

        FILE *flag_file = fopen("flag.txt", "r");
        if (flag_file == NULL) {
            printf("The purslane has been destroyed :(\n");
            return;
        }
        char flag[128];
        fgets(flag, sizeof(flag), flag_file);
        printf("%s\n", flag);
        fclose(flag_file);
    } else {
        printf("Idiot, pay me 36k for the re-tuition fee.\n");
    }
}

void menu() {
    printf("┌─────────────────────────────────────────────────────┐\n");
    printf("│            🎓 RAUMANIA UNIVERSITY 🎓                │\n");
    printf("├─────────────────────────────────────────────────────┤\n");
    printf("│  To graduate, you must solve my puzzle.             │\n");
    printf("│  Warning: If you don't graduate, you have           │\n");
    printf("│  to pay your tuition again and lose a slipper.      │\n");
    printf("├─────────────────────────────────────────────────────┤\n");
    printf("│  [1] Graduate                                       │\n");
    printf("│  [2] Exit                                           │\n");
    printf("└─────────────────────────────────────────────────────┘\n");
    printf(" 👉 Choose an option: ");
}

int main() {
    setbuf(stdout, NULL);
    setbuf(stdin, NULL);
    setbuf(stderr, NULL);

    menu();
    
    int choice;
    scanf("%d", &choice);
    if (choice == 1) {
        graduate();
    } else {
        printf("Goodbye!\n");
    }
    return 0;
}
