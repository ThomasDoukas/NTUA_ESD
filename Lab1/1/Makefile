all: phods opt_phods dse_phods dse_rect_phods

phods: phods.c
	@gcc phods.c -o phods -O0

opt_phods: opt_phods.c
	@gcc opt_phods.c -o opt_phods -O0
	
dse_phods: dse_phods.c
	@gcc dse_phods.c -o dse_phods -O0

dse_rect_phods: dse_rect_phods.c
	@gcc dse_rect_phods.c -o dse_rect_phods -O0

clean:
	@rm phods opt_phods dse_phods dse_rect_phods *.out *.err
