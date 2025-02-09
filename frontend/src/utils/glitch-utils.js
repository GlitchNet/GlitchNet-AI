import { ethers } from 'ethers';

export const interactWithContract = async (contractAddress, abi, method, args) => {
    try {
        const provider = new ethers.providers.Web3Provider(window.ethereum);
        const signer = provider.getSigner();
        const contract = new ethers.Contract(contractAddress, abi, signer);
        
        return await contract[method](...args);
    } catch (error) {
        throw new Error(`Blockchain interaction failed: ${error.message}`);
    }
};

export const simulateGlitchEffect = (element) => {
    const glitchStyles = [
        { filter: 'hue-rotate(180deg)', transform: 'skewX(10deg)' },
        { textShadow: '2px 2px #ff00ff', opacity: 0.8 },
        { clipPath: 'polygon(0 0, 100% 0, 100% 60%, 0 60%)' }
    ];
    
    element.style.transition = 'none';
    glitchStyles.forEach(style => {
        setTimeout(() => {
            Object.assign(element.style, style);
        }, Math.random() * 500);
    });
    
    setTimeout(() => {
        element.style = '';
    }, 1000);
};
