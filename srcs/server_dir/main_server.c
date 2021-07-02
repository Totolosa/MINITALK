#include "minitalk.h"

int	add_char(int *len, int *max, char c, char **str)
{
	char	*new;
	int		i;

	i = 0;
	new = NULL;
	if (*len >= *max)
	{
		*max *= 2;
		new = ft_calloc(*max + 1, sizeof(char));
		if (!new)
			return (0);
		while (i < *len)
		{
			new[i] = (*str)[i];
			i++;
		}
		free(*str);
		*str = new;
	}
	(*str)[*len] = c;
	return (1);
}

void	send_sig_server(int sig, siginfo_t *siginfo)
{
	static int	before_pid;

	if (siginfo->si_pid)
		before_pid = siginfo->si_pid;
	if (sig == SIGUSR1)
	{
		if (kill(before_pid, SIGUSR1))
			quit_prog("kill SIGUSR1 error\n");
	}
	else if (sig == SIGUSR2)
		if (kill(before_pid, SIGUSR2))
			quit_prog("kill SIGUSR2 error\n");
}

void	str_finished(int *i, char **str, siginfo_t *siginfo)
{
	send_sig_server(SIGUSR1, siginfo);
	send_sig_server(SIGUSR2, siginfo);
	ft_putstr_fd(*str, 1);
	free(*str);
	*str = NULL;
	*i = 0;
}

void	hdl_sigusr(int signum, siginfo_t *siginfo, void *context)
{
	static char	*str = 0;
	static int	c = 0;
	static int	i = 0;
	static int	bit = 7;
	static int	max = 8;

	(void)context;
	if (!str)
		str = ft_calloc(max, sizeof(char));
	if (signum == SIGUSR1)
		c += ft_pow(2, bit);
	bit--;
	if (bit < 0)
	{
		if (!add_char(&i, &max, c, &str))
			quit_prog("Error malloc str\n");
		if (c == 0)
			str_finished(&i, &str, siginfo);
		else
			i++;
		c = 0;
		bit = 7;
	}
	if (str)
		send_sig_server(SIGUSR1, siginfo);
}

int	main(int argc, char *argv[])
{
	struct sigaction	sa;

	(void)argv;
	if (argc != 1)
		quit_prog("Wrong number of arguments\n");
	ft_bzero(&sa, sizeof(sa));
	ft_putstr_fd("\033[32mPID = \033[1m", 1);
	ft_putnbr_fd(getpid(), 1);
	ft_putstr_fd("\033[0m\n", 1);
	sa.sa_flags = SA_SIGINFO;
	sa.sa_sigaction = &hdl_sigusr;
	sigaction(SIGUSR1, &sa, NULL);
	sigaction(SIGUSR2, &sa, NULL);
	while (42)
		pause();
	return (0);
}
