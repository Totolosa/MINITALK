#include "minitalk.h"

void	choose_signal(int nbr, int *res, int c, int pid)
{
	if (*res + nbr <= c)
	{
		kill(pid, SIGUSR1);
		*res += nbr;
		printf("res = %d\n", *res);
	}
	else
	{
		kill(pid, SIGUSR2);

	}
	sleep(1);
	// pause();
}

void	send_carac_bits(int c, int pid)
{
	int res;
	
	res = 0;
	choose_signal(128, &res, (int)c, pid);
	// printf("test\n");
	// printf("1 : res = %d\n", res);
	choose_signal(64, &res, (int)c, pid);
	// printf("2 : res = %d\n", res);
	choose_signal(32, &res, (int)c, pid);
	// printf("3 : res = %d\n", res);
	choose_signal(16, &res, (int)c, pid);
	// printf("4 : res = %d\n", res);
	choose_signal(8, &res, (int)c, pid);
	// printf("5 : res = %d\n", res);
	choose_signal(4, &res, (int)c, pid);
	// printf("6 : res = %d\n", res);
	choose_signal(2, &res, (int)c, pid);
	// printf("7 : res = %d\n", res);
	choose_signal(1, &res, (int)c, pid);
	// printf("8 : res = %d\n", res);
}

void	treat_str(int pid, char *str)
{
	int	i;
	// int	bit;
	// int	carac;
	
	i = -1;
	while (str[++i])
	{
		send_carac_bits(str[i], pid);
		printf("str[i] = %c\n", str[i]);
		// bit = -1;
		// while (++bit < 8)
		// {
		// 	printf("bit = %d\n", bit);
		// 	kill(pid, SIGUSR1);
		// 	pause();
		// }
	}
	
}

void	handle_sigusr(int signum, siginfo_t *info, void *context)
{
	// (void)signum;
	(void)context;
	(void)info;

	if (signum == SIGUSR2)
		printf("Message sent !\n");
}

int main(int argc, char *argv[])
{
	(void)argv;
	int	pid;
	struct sigaction sa;

	ft_putstr_fd("PID client = ", 1);
	ft_putnbr_fd(getpid(), 1);
	write(1, "\n", 1);
	
	sa.sa_flags = SA_SIGINFO;
	sa.sa_sigaction = handle_sigusr;
	sigaction(SIGUSR1, &sa, NULL);
	sigaction(SIGUSR2, &sa, NULL);
	if (argc != 3)
	{
		ft_putstr_fd("\033[31m\033[1mWrong number of arguments\n\033[0m", 1);
		exit(1);
	}
	pid = ft_atoi(argv[1]);
	if (pid <= 0 || pid > INT_MAX)
	{
		ft_putstr_fd("\033[31m\033[1mWrong PID\n\033[0m", 1);
		exit(1);
	}
	treat_str(pid, argv[2]);
	return (0);
}