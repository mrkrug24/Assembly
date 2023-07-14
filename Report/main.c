#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>
#include "my_lib.h"

typedef double(*function)(double x);

// для подсчета итераций при поиске соответствующих точек пересечения графиков функций
static int cnt = 0;
static int iter_12 = 0;
static int iter_13 = 0;
static int iter_23 = 0;

// функция root из условия
double root(function f_0, function f_1, function g_0, function g_1, double a, double b, double eps1) {
    int iter = 0;

    // точка пересечения графиков f1 и f3 соответствует случаю, при котором F`(x)*F``(x) < 0
    if (f_0 == f1_0 && g_0 == f3_0) {
        while (b - a >= eps1) {
            double f_dif_a = f_0(a) - g_0(a);
            double f_dif_b = f_0(b) - g_0(b);
            double f_dif_a_1 = f_1(a) - g_1(a);

            a -= f_dif_a / f_dif_a_1;
            b -= f_dif_b * (b - a) / (f_dif_b - f_dif_a);
            
            iter++;
        }

    // в остальных случаях F`(x)*F``(x) > 0
    } else {
        while (b - a >= eps1) {
            double f_dif_a = f_0(a) - g_0(a);
            double f_dif_b = f_0(b) - g_0(b);
            double f_dif_b_1 = f_1(b) - g_1(b);

            a -= f_dif_a * (b - a) / (f_dif_b - f_dif_a);
            b -= f_dif_b / f_dif_b_1;
            iter++;
        }
    }

    // присваивание соответствующим переменным количества итераций их значения
    if (cnt == 0) {
        iter_12 = iter;
    } else if (cnt == 1) {
        iter_13 = iter;
    } else {
        iter_23 = iter;
    }

    cnt++;

	return a;
}

// функция integral из условия
double integral(function f, double a, double b, double eps2) {
    double res = 0;
    double left = a;
    double right = a + eps2;

    // используем метод трапеций, изменяем res и сдвигаем левую и правую границы на eps2 
    while (left < b) {
        res += eps2 * (f(left) + f(right)) / 2;
        left += eps2;
        right += eps2;
    }

    return res;
}

// функция для вывода количества итераций
void number_of_iterations(int iter_12, int iter_13, int iter_23) {
    printf("Number of iterations through searching for intersection points:\n");
	printf("\tf1 and f2:\t%d\n", iter_12);
	printf("\tf1 and f3:\t%d\n", iter_13);
	printf("\tf2 and f3:\t%d\n", iter_23);
}

// функция для вывода абцисс точек пересечения графиков функций
void intersection_points(double x_12, double x_13, double x_23) {
    printf("Intersection points of the functions:\n");
	printf("\tf1 and f2:\tx = %lf\n", x_12);
	printf("\tf1 and f3:\tx = %lf\n", x_13);
	printf("\tf2 and f3:\tx = %lf\n", x_23);
}

// функция для вывода всех ключей
void help(void) {
	printf("Valid keys:\n");
	printf("\t--help\t\tprint valid keys\n");
    printf("\t--iter\t\tprint number of iterations through searching for intersection points\n");
	printf("\t--point\t\tprint intersection points of the functions\n");
    printf("\t--test_i\tthe user should enter integration boundaries for f1, f2 and f3 and then get result\n");
    printf("\t--test_p\tthe user should enter the boundaries to find the intersection points of the f1, f2, f3 and then get result\n");
}

// функция для тестирования функции root
void test_point(function f1_0, function f1_1, function f2_0, function f2_1, function f3_0, function f3_1, 
                double a_1, double b_1, double a_2, double b_2,  double a_3, double b_3, double eps1) {
    printf("Testing root function\n");
    printf("Intersection point of the functions:\n");
    printf("\tf1 and f2 is %lf\n", root(f1_0, f1_1, f2_0, f2_1, a_1, b_1, eps1));
    printf("\tf1 and f3 is %lf\n", root(f1_0, f1_1, f3_0, f3_1, a_2, b_2, eps1));
    printf("\tf2 and f3 is %lf\n", root(f2_0, f2_1, f3_0, f3_1, a_3, b_3, eps1));
}

// функция для тестирования функции integral
void test_integral(function f1_0, function f2_0, function f3_0, double a_1, double b_1, double a_2, double b_2,  double a_3, double b_3, double eps2) {
    printf("Testing integral function\n");
    printf("Test for f1 = 1 + 4 / (1 + x ^ 2)\n");
    printf("\tThe integral from %lf to %lf is equal to %lf\n\n", a_1, b_1, integral(f1_0, a_1, b_1, eps2));
    printf("Test for f2 = x ^ 3\n");
    printf("\tThe integral from %lf to %lf is equal to %lf\n\n", a_2, b_2, integral(f2_0, a_2, b_2, eps2));
    printf("Test for f3 = 2 ^ (-x)\n");
    printf("\tThe integral from %lf to %lf is equal to %lf\n", a_3, b_3, integral(f3_0, a_3, b_3, eps2));
}


int main (int argc, char *argv[]) {
    // подобранные значения эпсилон 1 и 2
    double eps1 = 0.00001;
    double eps2 = 0.00001;

    // подобранные отрезки для поиска точек пересечения графиков функция
    double a_12 = 1;
    double b_12 = 2; 
    double a_13 = -2;
    double b_13 = -1; 
    double a_23 = 0;
    double b_23 = 1; 

    // находим точки пересечения графиков функций
    double x_12 = root(f1_0, f1_1, f2_0, f2_1, a_12, b_12, eps1);
    double x_13 = root(f1_0, f1_1, f3_0, f3_1, a_13, b_13, eps1);
    double x_23 = root(f2_0, f2_1, f3_0, f3_1, a_23, b_23, eps1);

    // если ключей не было, то считаем площадь фигуры, ограниченной графиками функций f1, f2, f3
    if (argc == 1) {
        // считаем соответствующие интегралы
        double s_1 = integral(f1_0, x_13, x_12, eps2);
        double s_2 = integral(f2_0, x_23, x_12, eps2);
        double s_3 = integral(f3_0, x_13, x_23, eps2);

        // находим площадь
        double area = s_1 - s_2 - s_3;

        printf("The area of a figure bounded by functions is %.3lf", area);
        printf("\n\tf1 = 1 + 4 / (1 + x ^ 2)\n\tf2 = x ^ 3\n\tf3 = 2 ^ (-x)\n");

        return 0;
    } 

    // если же ключи были, составляем структуру со всеми доступными ключами
	const struct option long_options[] = {
        { "help", no_argument, NULL, 'h' },
		{ "iter", no_argument, NULL, 'i' },
		{ "point", no_argument, NULL, 'p' },
        { "test_i", required_argument, NULL, 't' },
        { "test_p", required_argument, NULL, 'q' },
		{ NULL, 0, NULL, 0 }
	};

    // считываем ключ
	int rez;
	int option_index;
    const char* short_options = "ipht:";
    rez = getopt_long(argc, argv, short_options, long_options, &option_index);

    // выролняем соответствующие инструкции
    if (rez == 'i') {
        number_of_iterations(iter_12, iter_13, iter_23);

    } else if (rez == 'p') {
        intersection_points(x_12, x_13, x_23);

    } else if (rez == 'h') {
        help();
        
    } else if (rez == 't') {
        if (argc < 8) {
            printf("Insufficient number of parameters, use the --help key to learn more information\n");
        } else {
            test_integral(f1_0, f2_0, f3_0, atoi(argv[2]), atoi(argv[3]), atoi(argv[4]), atoi(argv[5]),  atoi(argv[6]), atoi(argv[7]), eps2);
        }

    } else if (rez == 'q') {
         if (argc < 8) {
            printf("Insufficient number of parameters, use the --help key to learn more information\n");
        } else {
            test_point(f1_0, f1_1, f2_0, f2_1, f3_0, f3_1, atoi(argv[2]), atoi(argv[3]), atoi(argv[4]), atoi(argv[5]),  atoi(argv[6]), atoi(argv[7]), eps1);
        }
    } else {
         printf("unknown option\n");
    }

	return 0;
}