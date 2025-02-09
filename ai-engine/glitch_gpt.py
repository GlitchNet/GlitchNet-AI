import openai
import random

class GlitchGenerator:
    def __init__(self):
        self.constraints = [
            "Respond using mixed technical and poetic language",
            "Include at least one factual error",
            "Use deprecated technical terms",
            "Insert philosophical non-sequiturs"
        ]
    
    def generate_flawed_response(self, prompt):
        engineered_prompt = f"""
        [GLITCHNET PROTOCOL]
        {random.choice(self.constraints)}
        {prompt}
        """
        
        try:
            response = openai.ChatCompletion.create(
                model="gpt-4",
                messages=[{
                    "role": "system", 
                    "content": engineered_prompt
                }],
                temperature=1.8,
                max_tokens=256
            )
            return self._inject_glitches(response.choices[0].message['content'])
        except Exception as e:
            return f"ERROR: {str(e)}"

    def _inject_glitches(self, text):
        glitch_actions = [
            lambda s: s.replace(' ', '  '),
            lambda s: s.upper()[:len(s)//2] + s.lower()[len(s)//2:],
            lambda s: ''.join([c if random.random() > 0.1 else '�' for c in s])
        ]
        
        for _ in range(random.randint(1,3)):
            text = random.choice(glitch_actions)(text)
        return text
