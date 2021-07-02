#include "minitalk.h"

void	send_sig_client(int c, int nbr, long long pid)
{
	int	bit;

	if (c & nbr)
	{
		bit = 1;
		if (kill(pid, SIGUSR1))
			quit_prog("kill SIGUSR1 error\n");
	}
	else
	{
		bit = 0;
		if (kill(pid, SIGUSR2))
			quit_prog("kill SIGUSR2 error\n");
	}
	usleep(1000);
}

void	send_char(char c, long long pid)
{
	send_sig_client(c, 128, pid);
	send_sig_client(c, 64, pid);
	send_sig_client(c, 32, pid);
	send_sig_client(c, 16, pid);
	send_sig_client(c, 8, pid);
	send_sig_client(c, 4, pid);
	send_sig_client(c, 2, pid);
	send_sig_client(c, 1, pid);
}

void	send_str(char *str, long long pid)
{
	int	i;

	i = 0;
	while (str[i])
		send_char(str[i++], pid);
	send_char('\0', pid);
}

void	hdl_sigusr(int signum)
{
	if (signum == SIGUSR2)
		quit_prog("\nMessage sent!\n");
}

int	main(int argc, char *argv[])
{
	long long	pid;

	if (argc != 3)
		quit_prog("Wrong number of arguments\n");
	pid = ft_atoi(argv[1]);
	if (pid < 0 || pid > INT_MAX)
		quit_prog("Wrong PID number\n");
	signal(SIGUSR1, &hdl_sigusr);
	signal(SIGUSR2, &hdl_sigusr);
	send_str(argv[2], pid);
	while (42)
		pause();
	return (0);
}
