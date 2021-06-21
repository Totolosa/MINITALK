#include "minitalk.h"

void	treat_str(int pid, char *str)
{
	int	i;
	int	bit;
	// int	carac;
	
	i = -1;
	while (str[++i])
	{
		// carac =
		bit = -1;
		while (++bit < 8)
		{
			printf("bit = %d\n", bit);
			kill(pid, SIGUSR1);
			pause();
			// usleep(100);
		}


	}
	
}

void	handle_sigusr1(int signum, siginfo_t *info, void *context)
{
	(void)signum;
	(void)context;
	(void)info;

	// ft_putstr_fd("1 ", 1);

	// ft_putstr_fd("PID sender = ", 1);
	// ft_putnbr_fd(info->si_pid, 1);
	// write(1, "\n", 1);

	// kill(info->si_pid, SIGUSR1);
}

int main(int argc, char *argv[])
{
	(void)argv;
	int	pid;
	struct sigaction sa;

	sa.sa_flags = SA_SIGINFO;
	sa.sa_sigaction = handle_sigusr1;
	sigaction(SIGUSR1, &sa, NULL);
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