#include "minitalk.h"

// void	handle_sigtstp(int signum)
// {
// 	(void)signum;
// 	printf("NOT ALLOWED !\n");
// }

void	handle_sigusr1(int signum, siginfo_t *info, void *context)
{
	(void)signum;
	(void)context;
	ft_putstr_fd("1 ", 1);

	ft_putstr_fd("PID sender = ", 1);
	ft_putnbr_fd(info->si_pid, 1);
	write(1, "\n", 1);

	kill(info->si_pid, SIGUSR1);
	// printf("test");
}

int main(int argc, char *argv[])
{
	(void)argc;
	(void)argv;

	ft_putstr_fd("\033[32mPID = \033[1m", 1);
	ft_putnbr_fd(getpid(), 1);
	ft_putstr_fd("\033[0m\n", 1);

	struct sigaction sa;
	sa.sa_flags = SA_SIGINFO;
	sa.sa_sigaction = handle_sigusr1;
	sigaction(SIGUSR1, &sa, NULL);
	// sa.sa_handler = SA_RESTART;

	// signal(SIGUSR1, &handle_sigusr1);
	while (42);
	// int	pid;
	// pid = getpid();
	// sleep (1000);

	// int	x;
	// printf("Enter a number : ");
	// scanf("%d", &x);
	// printf("Result %d * 5 = %d\n", x, x * 5);
	return (0);
}