let currentLang = 'fr';
let currentSection = 'accueil';

// XSL fait TOUT - JS ne fait que transformer
function regenerateAllWithXSL(lang, section) {
    Promise.all([
        fetch('content.xml').then(res => res.text()),
        fetch('content.xsl').then(res => res.text())
    ]).then(([xmlText, xslText]) => {
        const parser = new DOMParser();
        const xml = parser.parseFromString(xmlText, 'text/xml');
        const xsl = parser.parseFromString(xslText, 'text/xml');
        
        const xsltProcessor = new XSLTProcessor();
        xsltProcessor.importStylesheet(xsl);
        
        // XSL génère TOUT avec les paramètres
        xsltProcessor.setParameter(null, 'lang', lang);
        xsltProcessor.setParameter(null, 'section', section);
        
        const result = xsltProcessor.transformToFragment(xml, document);
        
        // Remplacer TOUTE la page par le résultat XSL
        document.getElementById('app').innerHTML = '';
        document.getElementById('app').appendChild(result);
        
        // Mettre à jour l'attribut lang du HTML
        document.documentElement.setAttribute('lang', lang);
        
        // Réattacher les événements après génération XSL
        attachEvents();
    });
}

function attachEvents() {
    // Événements sur les boutons de langue
    document.querySelectorAll('.lang-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            const newLang = btn.getAttribute('data-lang');
            if (newLang === currentLang) return;
            
            currentLang = newLang;
            
            // Mettre à jour l'URL
            const urlParams = new URLSearchParams(window.location.search);
            urlParams.set('lang', currentLang);
            window.history.pushState({}, '', '?' + urlParams.toString());
            
            // XSL régénère TOUT
            regenerateAllWithXSL(currentLang, currentSection);
        });
    });
    
    // Événements sur les liens de menu
    document.querySelectorAll('.menu-link').forEach(link => {
        link.addEventListener('click', (e) => {
            e.preventDefault();
            const section = link.dataset.section;
            currentSection = section;
            
            // XSL régénère TOUT
            regenerateAllWithXSL(currentLang, currentSection);
        });
    });
}

function initPortfolio() {
    // Récupérer la langue depuis l'URL
    const urlParams = new URLSearchParams(window.location.search);
    let lang = urlParams.get('lang') || 'fr';
    currentLang = lang;
    
    // XSL génère TOUTE la page initiale
    regenerateAllWithXSL(currentLang, currentSection);
}

window.onload = initPortfolio;
