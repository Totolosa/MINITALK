#include "minitalk.h"

void	update_c(int signum, int *c, int *bit, siginfo_t *info)
{
	// (void)info;
	int	value_bit;
	int tmp;

	value_bit = 1;
	tmp = *bit + 1;
	while (--tmp > 0)
		value_bit *= 2;
	// printf("value_bit = %d, signal = ", value_bit);
	// if (signum == SIGUSR1)
	// 	write(1, "SIGUSR1\n", 8);
	// else
	// 	write(1, "SIGUSR2\n", 8);
	if (signum == SIGUSR1)
		*c += value_bit;
	// (*bit)++;
	// printf("test avant kill\n");
	kill(info->si_pid, SIGUSR1);

	// ft_putstr_fd("PID sender = ", 1);
	// ft_putnbr_fd(info->si_pid, 1);
	// write(1, "\n", 1);
}

void	handle_sigusr(int signum, siginfo_t *info, void *context)
{
	// (void)signum;
	(void)context;
	static	char *str = 0;
	static	int c = 0;
	static	int bit = 7;

	// printf("test\n");
	if (bit >= 0)
	{
		update_c(signum, &c, &bit, info);
		bit--;
		// kill(info->si_pid, SIGUSR1);
	}
	if (bit < 0)
	{
		// printf("dans else\n");
		// else
		// {
			// printf("avant ft_add_c_to_str : c = \n");
			ft_add_c_to_str((char)c, &str);
		// }
		if (c == 0)
		{
			ft_putstr_fd(str, 1);
			kill(info->si_pid, SIGUSR2);
			free(str);
			str = NULL;
		}
		bit = 7;
		c = 0;
	}
	// printf("bit = |%d|, c = |%d|, str = |%s|\n", bit, c, str);

	// ft_putstr_fd("PID sender = ", 1);
	// ft_putnbr_fd(info->si_pid, 1);
	// write(1, "\n", 1);
	// kill(info->si_pid, SIGUSR1);
}

int main(int argc, char *argv[])
{
	(void)argc;
	(void)argv;

	ft_putstr_fd("\033[32mPID = \033[1m", 1);
	ft_putnbr_fd(getpid(), 1);
	ft_putstr_fd("\033[0m\n", 1);

	setbuf(stdout, NULL);
	struct sigaction sa;
	sa.sa_flags = SA_SIGINFO;
	sa.sa_sigaction = handle_sigusr;
	sigaction(SIGUSR1, &sa, NULL);
	sigaction(SIGUSR2, &sa, NULL);
	while (42)
		usleep(800);
	return (0);
}