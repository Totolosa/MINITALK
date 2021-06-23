# ERASE	= \033[2K\r
# GREY	= \033[30m
# RED		= \033[31m
# GREEN	= \033[32m
# YELLOW	= \033[33m
# BLUE	= \033[34m
# PINK	= \033[35m
# CYAN	= \033[36m
# WHITE	= \033[37m
# END		= \033[0m
# BOLD	= \033[1m
# UNDER	= \033[4m
# SUR		= \033[7m

# NAME			= minitalk
# LST_SRCS		= main.c
# SRCS_DIR		= srcs
# DIR_OBJS		= objs
# SRCS			= $(addprefix $(SRCS_DIR)/,$(LST_SRCS))
# OBJS			= $(LST_SRCS:%.c=$(DIR_OBJS)/%.o)
# CC				= clang
# # CFLAGS			= -Wall -Werror -Wextra
# # CFLAGS			= -g
# CFLAGS			= -Wall -Werror -Wextra -fsanitize=address -g3
# # CFLAGS			= -fsanitize=address -g3
# INCLUDE			= -Iinclude -I${LIBFT}/include
# RM				= rm -rf
# MKDIR			= mkdir -p
# LIBFT			= libft

# all:			libft $(NAME)

# $(DIR_OBJS):
# 				$(MKDIR) $@

# libft:
# 				printf "$(ERASE)${GREEN}--> LIBFT <--${END}"
# 				make -C ${LIBFT} > SILENT
# 				$(RM) SILENT
# 				printf "$(ERASE)"

# ${NAME}:		libft/libft.a ${DIR_OBJS} ${OBJS}
# 				${CC} ${CFLAGS} ${INCLUDE} ${OBJS} -L ${LIBFT} -lft -o ${NAME}
# 				echo "$(BOLD)${GREEN}$(ERASE)--> minitalk generated <--${END}"

# $(DIR_OBJS)/%.o:$(SRCS_DIR)/%.c include/*.h
# 				$(MKDIR) $(dir $@)
# 				${CC} ${CFLAGS} $(INCLUDE) -c  $< -o $@
# 				printf "$(ERASE)--> [$(GREEN)$<$(END)] <--"

# clean:
# 				${RM} $(OBJS)
# 				make clean -C $(LIBFT) > SILENT
# 				$(RM) SILENT

# fclean:			clean
# 				${RM} $(DIR_OBJS) $(NAME)
# 				printf "$(ERASE)${GREEN}--> LIBFT CLEAN<--${END}"
# 				make fclean -C $(LIBFT) > SILENT
# 				$(RM) SILENT
# 				printf "$(ERASE)${GREEN}--> MINITALK CLEAN <--${END}"

# re:				fclean all

# .PHONY: 		clean fclean all re compil libft
# .SILENT:		clean fclean all re compil libft $(OBJS) $(NAME) $(DIR_OBJS)



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
SRCS_UTILS		=	
LST_UTILS		= $(addprefix $(DIR_UTILS)/,$(SRCS_UTILS))
LST_SERVER		= $(addprefix $(DIR_SERVER)/,$(SRCS_SERVER))
LST_CLIENT		= $(addprefix $(DIR_CLIENT)/,$(SRCS_CLIENT))
OBJS_UTILS		= ${LST_UTILS:srcs/%.c=$(DIR_OBJS)/%.o} 
OBJS_SERVER		= ${LST_SERVER:srcs/%.c=$(DIR_OBJS)/%.o} ${OBJS_UTILS}
OBJS_CLIENT		= ${LST_CLIENT:srcs/%.c=$(DIR_OBJS)/%.o} ${OBJS_UTILS}
DIR_OBJS		= objs
CC				= gcc
# CFLAGS			= -Wall -Werror -Wextra
CFLAGS			=  -g3 -Wall -Werror -Wextra -fsanitize=address
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





# NAME			= minitalk
# NAME1			= server
# NAME2			= client
# LST1			= \
# 	server.c \
# 	send.c
# LST2			= \
# 	client.c \
# 	send.c
# LST_SRCS		= \
# 	utils/write.c \
# 	utils/memory.c \
# 	utils/convertion.c \
# 	utils/math.c
# LST_SRCS1		= $(addprefix $(NAME1)/,$(LST1))
# LST_SRCS2		= $(addprefix $(NAME2)/,$(LST2))
# SRCS_DIR		= srcs
# DIR_OBJS		= objs
# OBJS			= $(LST_SRCS:%.c=$(DIR_OBJS)/%.o)
# OBJS1			= $(LST_SRCS1:%.c=$(DIR_OBJS)/%.o)
# OBJS2			= $(LST_SRCS2:%.c=$(DIR_OBJS)/%.o)
# CC				= clang
# FLAGS			= -Wall -Werror -Wextra
# CFLAGS			= -Iinc
# INCLUDE			= ./inc/*.h
# RM				= rm -rf
# MKDIR			= mkdir -p
# all:			$(NAME)

# $(DIR_OBJS):
# 				$(MKDIR) $@

# $(NAME1):		${DIR_OBJS} ${OBJS1} $(OBJS)
# 				${CC} ${FLAGS} ${CFLAGS} ${OBJS1} $(OBJS) -o ${NAME1}
# 				echo "$(BOLD)${GREEN}$(ERASE)--> ${NAME1} generated <--${END}"
				
# $(NAME2):		${DIR_OBJS} ${OBJS2} $(OBJS)
# 				${CC} ${FLAGS} ${CFLAGS} ${OBJS2} $(OBJS) -o ${NAME2}
# 				echo "$(BOLD)${GREEN}$(ERASE)--> ${NAME2} generated <--${END}"
				
# ${NAME}:		${DIR_OBJS} ${OBJS1} ${OBJS2} $(OBJS)
# 				${CC} ${FLAGS} ${CFLAGS} ${OBJS1} $(OBJS) -o ${NAME1}
# 				${CC} ${FLAGS} ${CFLAGS} ${OBJS2} $(OBJS) -o ${NAME2}
# 				echo "$(BOLD)${GREEN}$(ERASE)--> ${NAME1} generated <--${END}"
# 				echo "$(BOLD)${GREEN}$(ERASE)--> ${NAME2} generated <--${END}"
# 				echo "$(BOLD)${GREEN}$(ERASE)--> ${NAME} ready <--${END}"
				
# $(DIR_OBJS)/%.o:$(SRCS_DIR)/%.c $(INCLUDE)
# 				$(MKDIR) $(dir $@)
# 				${CC} ${FLAGS} $(CFLAGS) -c $< -o $@
# 				printf "$(ERASE)--> [$(GREEN)$<$(END)] <--"
				
# clean:
# 				${RM} $(OBJS1) $(OBJS2) $(OBJS)
				
# fclean:			clean
# 				${RM} $(DIR_OBJS) $(NAME1) $(NAME2)
# 				echo "$(ERASE)${GREEN}--> ${NAME} CLEAN <--${END}"
				
# re:				fclean all

# .PHONY: 		clean fclean all re compil libft
# .SILENT:		clean fclean all re compil libft $(OBJS) $(OBJS1) $(OBJS2) $(NAME) $(NAME1) $(NAME2) $(DIR_OBJS)