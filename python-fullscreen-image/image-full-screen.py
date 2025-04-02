import pygame
import sys

pygame.init()

windowSurface = pygame.display.set_mode((0, 0), pygame.FULLSCREEN)
img = pygame.image.load("DOOR SIGN.png")

run = True
while run:
        #events = pygame.event.get()
        for event in pygame.event.get():
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_ESCAPE:
                    pygame.quit()
                    sys.exit()
            
            
        windowSurface.blit(img, (0, 0)) #Replace (0, 0) with desired coordinates
        pygame.display.flip()