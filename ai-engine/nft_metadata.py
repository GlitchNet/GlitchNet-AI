import json
import hashlib
from datetime import datetime
from web3 import Web3

class GlitchMetadata:
    def __init__(self, ipfs_client):
        self.ipfs = ipfs_client
        self.error_types = {
            1: "Logic Corruption",
            2: "Temporal Paradox",
            3: "Semantic Collapse"
        }

    def generate_metadata(self, bug_report, ai_response):
        metadata = {
            "name": f"GlitchNet Bug #{bug_report['id']}",
            "description": self._create_description(bug_report, ai_response),
            "attributes": self._build_attributes(bug_report),
            "animation_url": f"ipfs://{self._store_glitch_animation(ai_response)}"
        }
        return self._upload_metadata(metadata)

    def _create_description(self, bug_report, response):
        return f"""## Cryptographic Anomaly Detected
**Error Code:** {bug_report['error_code']}
**AI Diagnosis:** {response[:200]}...
**Timestamp:** {datetime.utcfromtimestamp(bug_report['timestamp']).isoformat()}Z"""

    def _build_attributes(self, report):
        return [{
            "trait_type": "Chaos Level",
            "value": report['chaos_score']
        }, {
            "trait_type": "Error Class",
            "value": self.error_types.get(report['error_type'], "Unknown")
        }]

    def _store_glitch_animation(self, text):
        glitched = text.encode().hex()
        return self.ipfs.add_bytes(glitched)

    def _upload_metadata(self, data):
        json_data = json.dumps(data)
        return self.ipfs.add_json(json_data)
