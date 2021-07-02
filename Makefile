ERASE   = \033[2K\r
GREY    = \033[30m
RED     = \033[31m
GREEN   = \033[32m
YELLOW  = \033[33m
BLUE    = \033[34m
PINK    = \033[35m
CYAN    = \033[36m
WHITE   = \033[37m
END     = \033[0m
BOLD    = \033[1m
UNDER   = \033[4m
SUR     = \033[7m

NAME_SERVER		= server
NAME_CLIENT		= client
DIR_SRCS		= srcs
DIR_SERVER		= $(DIR_SRCS)/server_dir
DIR_CLIENT		= $(DIR_SRCS)/client_dir
DIR_UTILS		= $(DIR_SRCS)/utils
SRCS_SERVER		=	main_server.c 
SRCS_CLIENT		= 	main_client.c 
SRCS_UTILS		=	quit_prog.c
LST_UTILS		= $(addprefix $(DIR_UTILS)/,$(SRCS_UTILS))
LST_SERVER		= $(addprefix $(DIR_SERVER)/,$(SRCS_SERVER))
LST_CLIENT		= $(addprefix $(DIR_CLIENT)/,$(SRCS_CLIENT))
OBJS_UTILS		= ${LST_UTILS:srcs/%.c=$(DIR_OBJS)/%.o} 
OBJS_SERVER		= ${LST_SERVER:srcs/%.c=$(DIR_OBJS)/%.o} ${OBJS_UTILS}
OBJS_CLIENT		= ${LST_CLIENT:srcs/%.c=$(DIR_OBJS)/%.o} ${OBJS_UTILS}
DIR_OBJS		= objs
CC				= gcc
CFLAGS			= -Wall -Werror -Wextra
# CFLAGS			=  -g3 -Wall -Werror -Wextra -fsanitize=address
INCLUDE			= -Iinclude -I${LIBFT}/include
RM				= rm -rf
MKDIR			= mkdir -p
LIBFT			= libft

all:			libft ${NAME_SERVER} $(NAME_CLIENT)

$(DIR_OBJS):
				$(MKDIR) $@

libft: 
				make -C ${LIBFT}

${NAME_SERVER}:	libft/libft.a ${DIR_OBJS} ${OBJS_SERVER}
				${CC} ${CFLAGS} ${INCLUDE} ${OBJS_SERVER} -L ${LIBFT} -lft -o ${NAME_SERVER}
				echo "$(BOLD)${GREEN}$(ERASE)--> SERVER generated <--${END}"

${NAME_CLIENT}:	libft/libft.a ${DIR_OBJS} ${OBJS_CLIENT}
				${CC} ${CFLAGS} ${INCLUDE} ${OBJS_CLIENT} -L ${LIBFT} -lft -o ${NAME_CLIENT}
				echo "$(BOLD)${GREEN}--> CLIENT generated <--${END}"

$(DIR_OBJS)/%.o:$(DIR_SRCS)/%.c include/*.h
				$(MKDIR) $(dir $@)
				${CC} ${CFLAGS} $(INCLUDE) -c  $< -o $@

clean:
				${RM} ${OBJS_SERVER} ${OBJS_CLIENT}
				make clean -C $(LIBFT)

fclean:			clean
				${RM} $(DIR_OBJS) $(NAME_SERVER) ${NAME_CLIENT}
				make fclean -C $(LIBFT)
				echo "${RED}XXXXX CLEAN XXXXX${END}"

re:				fclean all

.PHONY: 		clean fclean all re compil libft
.SILENT:		clean fclean all re compil libft ${OBJS_SERVER} ${OBJS_CLIENT} $(NAME_SERVER) ${NAME_CLIENT} $(DIR_OBJS)
