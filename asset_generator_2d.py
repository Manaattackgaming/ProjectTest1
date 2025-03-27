import pygame
import numpy as np
from PIL import Image, ImageDraw, ImageFont
import os

# Initialize Pygame
pygame.init()

def create_triangular_prism_ship():
    """Generate the triangular prism player ship"""
    surface = pygame.Surface((512, 512), pygame.SRCALPHA)
    draw = pygame.draw
    
    # Draw the triangular prism
    points = [(256, 100), (156, 412), (356, 412)]
    draw.polygon(surface, (100, 100, 255, 255), points)
    
    # Add glowing forward point
    draw.circle(surface, (0, 255, 255, 255), (256, 100), 20)
    
    # Add engine vents
    for i in range(3):
        x = 156 + i * 100
        draw.rect(surface, (0, 255, 255, 128), (x-10, 400, 20, 20))
    
    pygame.image.save(surface, "assets/player_ship.png")

def create_sphere_projectile():
    """Generate the glowing sphere projectile"""
    surface = pygame.Surface((64, 64), pygame.SRCALPHA)
    draw = pygame.draw
    
    # Draw the glowing sphere
    center = (32, 32)
    radius = 20
    
    # Outer glow
    for i in range(3):
        draw.circle(surface, (0, 255, 255, 50-i*10), center, radius+i*5)
    
    # Core
    draw.circle(surface, (0, 255, 255, 255), center, radius)
    
    pygame.image.save(surface, "assets/projectile.png")

def create_circle_enemy():
    """Generate the floating circle enemy"""
    surface = pygame.Surface((512, 512), pygame.SRCALPHA)
    draw = pygame.draw
    
    center = (256, 256)
    radius = 100
    
    # Outer glow
    for i in range(3):
        draw.circle(surface, (255, 0, 0, 50-i*10), center, radius+i*10)
    
    # Main circle
    draw.circle(surface, (255, 0, 0, 255), center, radius)
    
    # Inner pulse
    draw.circle(surface, (255, 100, 100, 200), center, radius*0.7)
    
    pygame.image.save(surface, "assets/circle_enemy.png")

def create_cube_enemy():
    """Generate the cube enemy"""
    surface = pygame.Surface((512, 512), pygame.SRCALPHA)
    draw = pygame.draw
    
    # Draw cube from top-down perspective
    points = [(156, 156), (356, 156), (356, 356), (156, 356)]
    draw.polygon(surface, (255, 0, 0, 255), points)
    
    # Add glowing lines
    for i in range(4):
        start = points[i]
        end = points[(i+1)%4]
        draw.line(surface, (255, 255, 255, 200), start, end, 3)
    
    pygame.image.save(surface, "assets/cube_enemy.png")

def create_asteroid():
    """Generate the asteroid"""
    surface = pygame.Surface((512, 512), pygame.SRCALPHA)
    draw = pygame.draw
    
    # Create jagged shape
    points = []
    center = (256, 256)
    radius = 100
    num_points = 8
    
    for i in range(num_points):
        angle = (2 * np.pi * i) / num_points
        r = radius + np.random.randint(-20, 20)
        x = center[0] + r * np.cos(angle)
        y = center[1] + r * np.sin(angle)
        points.append((x, y))
    
    draw.polygon(surface, (100, 100, 100, 255), points)
    
    pygame.image.save(surface, "assets/asteroid.png")

def create_certificate():
    """Generate the Certificate of Awesomeness"""
    img = Image.new('RGBA', (1024, 768), (255, 255, 255, 255))
    draw = ImageDraw.Draw(img)
    
    # Add golden border
    draw.rectangle([(0, 0), (1023, 767)], outline=(255, 215, 0, 255), width=10)
    
    # Add title
    try:
        font = ImageFont.truetype("arial.ttf", 72)
    except:
        font = ImageFont.load_default()
    
    draw.text((512, 100), "Certificate of Awesomeness", font=font, fill=(0, 0, 0, 255), anchor="mm")
    
    # Add space for text
    draw.rectangle([(100, 200), (924, 568)], outline=(200, 200, 200, 255))
    
    img.save("assets/certificate.png")

def create_ui_elements():
    """Generate UI elements"""
    # Health bar
    health_surface = pygame.Surface((200, 20), pygame.SRCALPHA)
    pygame.draw.rect(health_surface, (0, 255, 0, 255), (0, 0, 200, 20))
    pygame.image.save(health_surface, "assets/health_bar.png")
    
    # Timer bar
    timer_surface = pygame.Surface((200, 20), pygame.SRCALPHA)
    pygame.draw.rect(timer_surface, (0, 0, 255, 255), (0, 0, 200, 20))
    pygame.image.save(timer_surface, "assets/timer_bar.png")
    
    # Score counter frame
    score_surface = pygame.Surface((150, 50), pygame.SRCALPHA)
    pygame.draw.rect(score_surface, (255, 255, 255, 128), (0, 0, 150, 50), 2)
    pygame.image.save(score_surface, "assets/score_frame.png")

def main():
    # Create assets directory if it doesn't exist
    if not os.path.exists("assets"):
        os.makedirs("assets")
    
    # Create all assets
    create_triangular_prism_ship()
    create_sphere_projectile()
    create_circle_enemy()
    create_cube_enemy()
    create_asteroid()
    create_certificate()
    create_ui_elements()
    
    pygame.quit()

if __name__ == "__main__":
    main() 