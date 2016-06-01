FILE_lex = B023040044.l
PROG_lex = lex.yy.c
FILE_yacc = B023040044.y
PROG_yacc = y.tab.c
all: $(PROG_lex) $(PROG_yacc)
	gcc $(PROG_lex) $(PROG_yacc) -lm -ly -lfl
$(PROG_lex):	$(FILE_lex)
	flex $(FILE_lex)
$(PROG_yacc):	$(FILE_yacc)
	bison -y -d $(FILE_yacc)
clean:
	rm -f a.out $(PROG_yacc) $(PROG_lex) y.tab.h
