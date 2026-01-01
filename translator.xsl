<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
<xsl:output method="html" indent="yes" doctype-system="about:legacy-compat"/>

<xsl:template match="/">
    <html lang="bg">
        <head>
            <title>ФМИ ИТ ПРОДУКТИ</title> <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
            <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700&amp;family=Roboto:wght@300;400;700&amp;display=swap" rel="stylesheet"/>
            <style>
                :root {
                    --bg-dark: #0f172a;
                    --card-bg: #1e293b;
                    --accent: #38bdf8; /* Sky Blue Neon */
                    --accent-hover: #0ea5e9;
                    --text-main: #f1f5f9;
                    --text-secondary: #94a3b8;
                    --border: #334155;
                }

                body {
                    font-family: 'Roboto', sans-serif;
                    background-color: var(--bg-dark);
                    color: var(--text-main);
                    margin: 0;
                    padding: 0;
                }

                /* Header Styling */
                .navbar {
                    background: rgba(15, 23, 42, 0.95);
                    border-bottom: 1px solid var(--border);
                    padding: 1rem 2rem;
                    position: sticky;
                    top: 0;
                    z-index: 100;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    backdrop-filter: blur(10px);
                    box-shadow: 0 4px 20px rgba(0,0,0,0.5);
                }

                .brand-logo {
                    font-family: 'Orbitron', sans-serif;
                    font-size: 1.8rem;
                    color: var(--accent);
                    text-transform: uppercase;
                    letter-spacing: 2px;
                    text-shadow: 0 0 10px rgba(56, 189, 248, 0.5);
                }

                .container {
                    max-width: 1400px;
                    margin: 0 auto;
                    padding: 2rem;
                    display: grid;
                    grid-template-columns: 280px 1fr; /* Sidebar + Grid */
                    gap: 2rem;
                }

                .sidebar {
                    background: var(--card-bg);
                    padding: 1.5rem;
                    border-radius: 12px;
                    border: 1px solid var(--border);
                    height: fit-content;
                    position: sticky;
                    top: 100px;
                }

                .sidebar h3 {
                    margin-top: 0;
                    font-family: 'Orbitron', sans-serif;
                    border-bottom: 2px solid var(--accent);
                    padding-bottom: 10px;
                    font-size: 1.1rem;
                }

                .filter-group {
                    margin-bottom: 1.5rem;
                }

                .filter-label {
                    display: block;
                    margin-bottom: 0.5rem;
                    color: var(--text-secondary);
                    font-size: 0.9rem;
                    font-weight: bold;
                }

                select {
                    width: 100%;
                    padding: 10px;
                    background: var(--bg-dark);
                    color: var(--text-main);
                    border: 1px solid var(--border);
                    border-radius: 6px;
                    outline: none;
                    cursor: pointer;
                    transition: border 0.3s;
                }

                select:focus {
                    border-color: var(--accent);
                }

                #products-grid {
                    display: grid;
                    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
                    gap: 20px;
                }

                .tech-card {
                    background: var(--card-bg);
                    border: 1px solid var(--border);
                    border-radius: 12px;
                    padding: 1.5rem;
                    transition: all 0.3s ease;
                    position: relative;
                    overflow: hidden;
                    display: flex;
                    flex-direction: column;
                }

                .tech-card:hover {
                    transform: translateY(-5px);
                    border-color: var(--accent);
                    box-shadow: 0 10px 30px rgba(56, 189, 248, 0.15);
                }

                .card-img-container {
                    height: 200px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    margin-bottom: 1rem;
                    background: rgba(255,255,255,0.02);
                    border-radius: 8px;
                }

                .tech-card img {
                    max-width: 100%;
                    max-height: 180px;
                    object-fit: contain;
                    filter: drop-shadow(0 5px 5px rgba(0,0,0,0.3));
                }

                .card-brand {
                    color: var(--accent);
                    font-size: 0.8rem;
                    text-transform: uppercase;
                    letter-spacing: 1px;
                    font-weight: bold;
                }

                .card-title {
                    font-size: 1.1rem;
                    margin: 0.5rem 0;
                    font-weight: bold;
                    flex-grow: 1;
                }

                .card-price {
                    font-family: 'Orbitron', sans-serif;
                    font-size: 1.4rem;
                    color: #fff;
                    margin: 1rem 0;
                }

                .btn-details {
                    width: 100%;
                    padding: 12px;
                    background: transparent;
                    border: 2px solid var(--accent);
                    color: var(--accent);
                    font-weight: bold;
                    border-radius: 6px;
                    cursor: pointer;
                    transition: all 0.3s;
                    text-transform: uppercase;
                    font-size: 0.9rem;
                }

                .btn-details:hover {
                    background: var(--accent);
                    color: var(--bg-dark);
                    box-shadow: 0 0 15px var(--accent);
                }

                .modal-overlay {
                    position: fixed;
                    top: 0; left: 0; width: 100%; height: 100%;
                    background: rgba(0,0,0,0.85);
                    z-index: 1000;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    opacity: 0;
                    visibility: hidden;
                    transition: opacity 0.3s;
                }

                .modal-overlay.active {
                    opacity: 1;
                    visibility: visible;
                }

                .modal-content {
                    background: var(--card-bg);
                    width: 90%;
                    max-width: 900px;
                    max-height: 90vh;
                    overflow-y: auto;
                    border-radius: 16px;
                    border: 1px solid var(--accent);
                    padding: 2rem;
                    position: relative;
                    box-shadow: 0 0 50px rgba(56, 189, 248, 0.2);
                    display: grid;
                    grid-template-columns: 1fr 1fr;
                    gap: 2rem;
                }

                .close-modal {
                    position: absolute;
                    top: 15px;
                    right: 20px;
                    font-size: 2rem;
                    color: var(--text-secondary);
                    cursor: pointer;
                    background: none;
                    border: none;
                }
                
                .close-modal:hover { color: #fff; }

                .specs-table {
                    width: 100%;
                    border-collapse: collapse;
                    margin-top: 1rem;
                }
                
                .specs-table td {
                    padding: 8px 0;
                    border-bottom: 1px solid var(--border);
                    color: var(--text-secondary);
                }

                .specs-table td:last-child {
                    color: #fff;
                    text-align: right;
                    font-weight: bold;
                }

                .modal-image-box {
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    background: rgba(0,0,0,0.2);
                    border-radius: 12px;
                }
                
                .modal-image-box img {
                    max-width: 100%;
                    max-height: 350px;
                }

                .hidden { display: none !important; }

                /* Mobile Responsiveness */
                @media (max-width: 768px) {
                    .container { grid-template-columns: 1fr; }
                    .sidebar { position: static; margin-bottom: 2rem; }
                    .modal-content { grid-template-columns: 1fr; }
                }
            </style>
            
            <script>
                function filterProducts() {
                    const type = document.getElementById('typeFilter').value;
                    const brand = document.getElementById('brandFilter').value;
                    const cards = document.querySelectorAll('.tech-card');
                    
                    cards.forEach(card => {
                        const pType = card.getAttribute('data-type');
                        const pBrand = card.getAttribute('data-brand');
                        
                        const typeMatch = (type === 'all' || pType === type);
                        const brandMatch = (brand === 'all' || pBrand === brand);

                        if (typeMatch &amp;&amp; brandMatch) {
                            card.classList.remove('hidden');
                        } else {
                            card.classList.add('hidden');
                        }
                    });
                }

                function sortProducts(value) {
                    const [criteria, direction] = value.split('-');
                    const container = document.getElementById('products-grid');
                    const cards = Array.from(container.getElementsByClassName('tech-card'));
                    
                    cards.sort((a, b) => {
                        let valA, valB;
                        
                        if (criteria === 'price') {
                            valA = parseFloat(a.getAttribute('data-price'));
                            valB = parseFloat(b.getAttribute('data-price'));
                            return direction === 'asc' ? valA - valB : valB - valA;
                        } else {
                            valA = a.getAttribute('data-name').toLowerCase();
                            valB = b.getAttribute('data-name').toLowerCase();
                            return direction === 'asc' ? valA.localeCompare(valB) : valB.localeCompare(valA);
                        }
                    });

                    cards.forEach(card => container.appendChild(card));
                }

                function openModal(id) {
                    document.getElementById('modal-' + id).classList.add('active');
                    document.body.style.overflow = 'hidden'; // Prevent scrolling
                }

                function closeModal(id) {
                    document.getElementById('modal-' + id).classList.remove('active');
                    document.body.style.overflow = 'auto';
                }
            </script>
        </head>
        <body>
            <div class="navbar">
                <div class="brand-logo">ФМИ <span style="color:#fff; font-size:0.8em">ИТ Продукти</span></div>
                <div style="color: var(--text-secondary); font-size: 0.9rem;">
                    Каталог ИТ Продукти 2025 задание 16
                </div>
            </div>

            <div class="container">
                <aside class="sidebar">
                    <h3>Филтриране</h3>
                    <div class="filter-group">
                        <label class="filter-label">Категория</label>
                        <select id="typeFilter" onchange="filterProducts()">
                            <option value="all">Всички продукти</option>
                            <xsl:for-each select="catalog/products/product/@xsi:type[not(. = preceding::product/@xsi:type)]">
                                <option value="{.}">
                                    <xsl:choose>
                                        <xsl:when test=".='keyboardType'">Клавиатури</xsl:when>
                                        <xsl:when test=".='mouseType'">Мишки</xsl:when>
                                        <xsl:when test=".='laptopType'">Лаптопи</xsl:when>
                                        <xsl:when test=".='desktopType'">Компютри</xsl:when>
                                        <xsl:when test=".='displayType'">Монитори</xsl:when>
                                        <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
                                    </xsl:choose>
                                </option>
                            </xsl:for-each>
                        </select>
                    </div>

                    <div class="filter-group">
                        <label class="filter-label">Марка</label>
                        <select id="brandFilter" onchange="filterProducts()">
                            <option value="all">Всички марки</option>
                            <xsl:for-each select="catalog/brands/brand">
                                <option><xsl:value-of select="."/></option>
                            </xsl:for-each>
                        </select>
                    </div>

                    <h3>Сортиране</h3>
                    <div class="filter-group">
                        <select onchange="sortProducts(this.value)">
                            <option value="name-asc">Име (А-Я)</option>
                            <option value="name-desc">Име (Я-А)</option>
                            <option value="price-asc">Цена (Ниска -> Висока)</option>
                            <option value="price-desc">Цена (Висока -> Ниска)</option>
                        </select>
                    </div>
                </aside>

                <main id="products-grid">
                    <xsl:apply-templates select="catalog/products/product">
                        <xsl:sort select="name"/>
                    </xsl:apply-templates>
                </main>
            </div>

            <xsl:apply-templates select="catalog/products/product" mode="modal"/>
        </body>
    </html>
</xsl:template>

<xsl:template match="product">
    <div class="tech-card">
        <xsl:attribute name="data-type"><xsl:value-of select="@xsi:type"/></xsl:attribute>
        <xsl:attribute name="data-brand"><xsl:value-of select="brand"/></xsl:attribute>
        <xsl:attribute name="data-name"><xsl:value-of select="name"/></xsl:attribute>
        <xsl:attribute name="data-price">
            <xsl:choose>
                <xsl:when test="price/@currency = 'EUR'">
                    <xsl:value-of select="price * 1.95583"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="price"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>

        <div class="card-img-container">
            <img>
                <xsl:attribute name="src">
                    <xsl:value-of select="unparsed-entity-uri(image/@src)"/>
                </xsl:attribute>
                <xsl:attribute name="alt"><xsl:value-of select="name"/></xsl:attribute>
            </img>
        </div>
        
        <div class="card-brand"><xsl:value-of select="brand"/></div>
        <div class="card-title"><xsl:value-of select="name"/></div>
        
        <div class="card-price">
            <xsl:value-of select="price"/> 
            <span style="font-size:0.6em; margin-left:5px;"><xsl:value-of select="price/@currency"/></span>
        </div>

        <button class="btn-details" onclick="openModal('{model}')">
            Преглед
        </button>
    </div>
</xsl:template>

<xsl:template match="product" mode="modal">
    <div class="modal-overlay" id="modal-{model}">
        <div class="modal-content">
            <button class="close-modal" onclick="closeModal('{model}')">×</button>
            
            <div class="modal-image-box">
                <img>
                    <xsl:attribute name="src">
                        <xsl:value-of select="unparsed-entity-uri(image/@src)"/>
                    </xsl:attribute>
                </img>
            </div>

            <div class="modal-info">
                <h2 style="margin-top:0; color: var(--accent);"><xsl:value-of select="name"/></h2>
                <p style="color: var(--text-secondary); line-height:1.6;">
                    Професионален клас оборудване от <xsl:value-of select="brand"/>. 
                    <xsl:if test="colors">Наличен в цветове: 
                        <xsl:for-each select="colors/color">
                            <span style="color:#fff; margin-right:5px;"><xsl:value-of select="."/></span>
                        </xsl:for-each>
                    </xsl:if>
                </p>

                <table class="specs-table">
                    <tr><td>Модел</td><td><xsl:value-of select="model"/></td></tr>
                    
                    <xsl:choose>
                        <xsl:when test="@xsi:type='laptopType' or @xsi:type='desktopType'">
                            <tr><td>Процесор</td><td><xsl:value-of select="processor"/></td></tr>
                            <tr><td>RAM Памет</td><td><xsl:value-of select="ram"/> GB</td></tr>
                            <tr><td>Съхранение</td><td><xsl:value-of select="storage"/> <xsl:value-of select="storage/@unit"/></td></tr>
                            <tr><td>ОС</td><td><xsl:value-of select="os"/></td></tr>
                            <xsl:if test="display">
                                <tr><td>Екран</td><td><xsl:value-of select="display/diagonalSize"/>" <xsl:value-of select="display/resolution"/></td></tr>
                            </xsl:if>
                        </xsl:when>
                        
                        <xsl:when test="@xsi:type='keyboardType'">
                            <tr><td>Тип</td><td><xsl:value-of select="type"/></td></tr>
                            <tr><td>Формат</td><td>
                                <xsl:choose>
                                    <xsl:when test="full-sized='true'">Пълноразмерна</xsl:when>
                                    <xsl:otherwise>Компактна (TKL)</xsl:otherwise>
                                </xsl:choose>
                            </td></tr>
                            <tr><td>Свързаност</td><td><xsl:value-of select="connectivity"/></td></tr>
                        </xsl:when>

                        <xsl:when test="@xsi:type='mouseType'">
                            <tr><td>DPI</td><td><xsl:value-of select="dpi"/></td></tr>
                            <tr><td>Бутони</td><td><xsl:value-of select="buttons"/></td></tr>
                            <tr><td>Свързаност</td><td><xsl:value-of select="connectivity"/></td></tr>
                        </xsl:when>

                        <xsl:when test="@xsi:type='displayType'">
                            <tr><td>Резолюция</td><td><xsl:value-of select="resolution"/></td></tr>
                            <tr><td>Опресняване</td><td><xsl:value-of select="refreshRate"/> Hz</td></tr>
                            <tr><td>Размер</td><td><xsl:value-of select="diagonalSize"/> инча</td></tr>
                        </xsl:when>
                    </xsl:choose>
                </table>

                <div style="margin-top: 2rem; display: flex; justify-content: space-between; align-items: center;">
                    <div class="card-price" style="margin:0;">
                        <xsl:value-of select="price"/> <xsl:value-of select="price/@currency"/>
                    </div>
                    <button class="btn-details" style="width: auto; background: var(--accent); color: var(--bg-dark);">
                        Купи сега
                    </button>
                </div>
            </div>
        </div>
    </div>
</xsl:template>

</xsl:stylesheet>