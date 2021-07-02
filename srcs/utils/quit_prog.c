#include "minitalk.h"

void	quit_prog(char *str)
{
	if (str)
		ft_putstr_fd(str, 1);
	exit(1);
}
