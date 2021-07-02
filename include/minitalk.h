#ifndef MINITALK_H
# define MINITALK_H

# include <stdlib.h>
# include <unistd.h>
# include <stdio.h>
# include <signal.h>
# include <limits.h>
# include "libft.h"

void	quit_prog(char *str);

typedef struct s_global
{
	int	c;
}		t_global;

t_global	g_global;

#endif