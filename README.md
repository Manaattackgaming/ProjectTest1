# Game Asset Generator

This Python script generates various game assets for a space shooter game using Pygame and OpenGL.

## Requirements

- Python 3.8 or higher
- Pygame
- NumPy
- Pillow
- PyOpenGL
- PyOpenGL-accelerate

## Installation

1. Install the required dependencies:
```bash
pip install -r requirements.txt
```

## Usage

Run the script to generate all game assets:
```bash
python asset_generator.py
```

The generated assets will be saved in the `assets` directory:

- `player_ship.png`: Triangular prism spaceship with glowing elements
- `projectile.png`: Glowing energy sphere projectile
- `circle_enemy.png`: Floating red circle enemy
- `cube_enemy.png`: Red-glowing cube enemy
- `asteroid.png`: Jagged asteroid obstacle
- `certificate.png`: Certificate of Awesomeness
- `health_bar.png`: Health bar UI element
- `timer_bar.png`: Timer bar UI element
- `score_frame.png`: Score counter frame

## Asset Descriptions

1. **Player Ship**: A triangular prism spaceship with a glowing forward point and blue engine vents
2. **Projectile**: A glowing blue energy sphere with light trails
3. **Circle Enemy**: A floating red circle with an inner pulse effect
4. **Cube Enemy**: A red-glowing cube with sharp glowing lines
5. **Asteroid**: A jagged, rocky asteroid with varying shapes
6. **Certificate**: An official-looking certificate with golden border and space theme
7. **UI Elements**: Minimalist sci-fi UI components including health bar, timer, and score counter 