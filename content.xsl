<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:param name="lang" select="'fr'"/>
  <xsl:param name="section" select="'accueil'"/>
  <xsl:output method="html" indent="yes" encoding="UTF-8"/>
  <xsl:strip-space elements="*"/>

  <!-- Template principal -->
  <xsl:template match="/content">
    <!-- Boutons de langue -->
    <div class="lang-btns-top">
      <button class="lang-btn" data-lang="fr" type="button">
        <xsl:if test="$lang='fr'">
          <xsl:attribute name="class">lang-btn selected</xsl:attribute>
        </xsl:if>
        FR
      </button>
      <button class="lang-btn" data-lang="en" type="button">
        <xsl:if test="$lang='en'">
          <xsl:attribute name="class">lang-btn selected</xsl:attribute>
        </xsl:if>
        EN
      </button>
      <button class="lang-btn" data-lang="ar" type="button">
        <xsl:if test="$lang='ar'">
          <xsl:attribute name="class">lang-btn selected</xsl:attribute>
        </xsl:if>
        AR
      </button>
    </div>
    
    <!-- Structure principale  -->
    <div class="main-layout" typeof="foaf:Person" about="#amziane">
      <!-- Métadonnées principales cachées -->
      <div style="display: none;">
        <span property="foaf:name" xml:lang="{$lang}">
          <xsl:choose>
            <xsl:when test="$lang='fr'">Amziane HAMRANI</xsl:when>
            <xsl:when test="$lang='en'">Amziane HAMRANI</xsl:when>
            <xsl:when test="$lang='ar'">أمزيان حمراني</xsl:when>
          </xsl:choose>
        </span>
        <span property="foaf:mbox" resource="mailto:amziane.hamrani@gmail.com"/>
        <span property="foaf:phone">+33 7 76 97 94 73</span>
      </div>
      
      <!-- Sidebar -->
      <div class="sidebar">
        <xsl:apply-templates select="sidebar/lang[@code=$lang]"/>
      </div>
      
      <!-- Contenu principal -->
      <div class="content">
        <xsl:choose>
          <xsl:when test="$section='accueil'">
            <xsl:apply-templates select="presentation/lang[@code=$lang]"/>
          </xsl:when>
          <xsl:when test="$section='infos'">
            <xsl:apply-templates select="personal_info/lang[@code=$lang]"/>
          </xsl:when>
          <xsl:when test="$section='educations'">
            <xsl:apply-templates select="educations/lang[@code=$lang]"/>
          </xsl:when>
          <xsl:when test="$section='experiences'">
            <xsl:apply-templates select="experiences/lang[@code=$lang]"/>
          </xsl:when>
          <xsl:when test="$section='projects'">
            <xsl:apply-templates select="projects/lang[@code=$lang]"/>
          </xsl:when>
          <xsl:when test="$section='skills'">
            <xsl:apply-templates select="skills/lang[@code=$lang]"/>
          </xsl:when>
          <xsl:when test="$section='interests'">
            <xsl:apply-templates select="interests/lang[@code=$lang]"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates select="presentation/lang[@code=$lang]"/>
          </xsl:otherwise>
        </xsl:choose>
      </div>
    </div>
  </xsl:template>

  <!-- Sidebar  -->
  <xsl:template match="sidebar/lang">
    <div class="sidebar-header">
      <img class="avatar" src="https://avatars.githubusercontent.com/u/10880619?v=4" alt="Avatar"/>
      <div class="author">
        <h1 class="name">Amziane HAMRANI</h1>
        <h2 class="role"><xsl:value-of select="role"/></h2>
        <p class="bio">
          <xsl:choose>
            <xsl:when test="@code='fr'">Portfolio technique démontrant mes compétences en développement web et technologies sémantiques.</xsl:when>
            <xsl:when test="@code='en'">Technical portfolio demonstrating my skills in web development and semantic technologies.</xsl:when>
            <xsl:when test="@code='ar'">بورتفوليو تقني يُظهر مهاراتي في تطوير الويب والتقنيات الدلالية.</xsl:when>
          </xsl:choose>
        </p>
      </div>
    </div>
    
    <div class="menu">
      <!-- Lien Accueil -->
      <a href="#accueil" class="menu-link" data-section="accueil">
        <xsl:if test="$section='accueil'">
          <xsl:attribute name="class">menu-link active</xsl:attribute>
        </xsl:if>
        <xsl:choose>
          <xsl:when test="@code='fr'">Accueil</xsl:when>
          <xsl:when test="@code='en'">Home</xsl:when>
          <xsl:when test="@code='ar'">الرئيسية</xsl:when>
        </xsl:choose>
      </a>
      
      <!-- Liens du menu -->
      <xsl:for-each select="menu/item">
        <a href="#{@id}" class="menu-link" data-section="{@id}">
          <xsl:if test="@id=$section">
            <xsl:attribute name="class">menu-link active</xsl:attribute>
          </xsl:if>
          <xsl:value-of select="."/>
        </a>
      </xsl:for-each>
    </div>
  </xsl:template>

  <!-- Présentation -->
  <xsl:template match="presentation/lang">
    <div class="block">
      <h2 class="titre"><xsl:value-of select="title"/></h2>
      <div class="timeline-desc">
        <xsl:copy-of select="desc/node()"/>
      </div>
      
      <!-- Vidéo YouTube -->
      <xsl:if test="video">
        <div style="margin-top: 30px;">
          <iframe src="{video}" width="800" height="450"
                  title="Présentation vidéo" frameborder="0" allowfullscreen="allowfullscreen"
                  property="portfolio:presentationVideo" resource="{video}">
          </iframe>
        </div>
      </xsl:if>
    </div>
  </xsl:template>

  <!-- Infos personnelles -->
  <xsl:template match="personal_info/lang">
    <div class="block" id="infos">
      <h2 class="titre">
        <xsl:choose>
          <xsl:when test="@code='fr'">À propos</xsl:when>
          <xsl:when test="@code='en'">About</xsl:when>
          <xsl:when test="@code='ar'">حول</xsl:when>
        </xsl:choose>
      </h2>
      <div class="timeline-item">
        <div class="timeline-date">Contact</div>
        <div class="timeline-content">
          <ul>
            <xsl:if test="firstname and name">
              <li><strong>
                <xsl:choose>
                  <xsl:when test="@code='fr'">Nom :</xsl:when>
                  <xsl:when test="@code='en'">Name:</xsl:when>
                  <xsl:when test="@code='ar'">الاسم:</xsl:when>
                </xsl:choose>
              </strong> 
              <span property="foaf:name"><xsl:value-of select="firstname"/> <xsl:value-of select="name"/></span>
              </li>
            </xsl:if>
            <xsl:if test="email">
              <li><strong>Email :</strong> 
                <a href="mailto:{email}" property="foaf:mbox" resource="mailto:{email}">
                  <xsl:value-of select="email"/>
                </a>
              </li>
            </xsl:if>
            <xsl:if test="phone">
              <li><strong>
                <xsl:choose>
                  <xsl:when test="@code='fr'">Téléphone :</xsl:when>
                  <xsl:when test="@code='en'">Phone:</xsl:when>
                  <xsl:when test="@code='ar'">الهاتف:</xsl:when>
                </xsl:choose>
              </strong> 
              <span property="foaf:phone"><xsl:value-of select="phone"/></span>
              </li>
            </xsl:if>
          </ul>
        </div>
      </div>
    </div>
  </xsl:template>

  <!-- Formations -->
  <xsl:template match="educations/lang">
    <div class="block" id="educations">
      <h2 class="titre">
        <xsl:choose>
          <xsl:when test="@code='fr'">Formation</xsl:when>
          <xsl:when test="@code='en'">Education</xsl:when>
          <xsl:when test="@code='ar'">التعليم</xsl:when>
        </xsl:choose>
      </h2>
      <div class="timeline-list">
        <xsl:for-each select="education">
          <div class="timeline-item" typeof="portfolio:AcademicDegree">
            <div class="timeline-date"><xsl:value-of select="year"/></div>
            <div class="timeline-content">
              <h3 class="timeline-title" property="dc:title">
                <xsl:value-of select="title"/>
              </h3>
              <div class="timeline-location">
                <span property="portfolio:educationalInstitution">
                  <xsl:value-of select="university"/>
                </span>
                <xsl:if test="location">
                  <span style="color: #64748b;"> • </span>
                  <span property="portfolio:location"><xsl:value-of select="location"/></span>
                </xsl:if>
              </div>
            </div>
          </div>
        </xsl:for-each>
      </div>
    </div>
  </xsl:template>

  <!-- Expériences -->
  <xsl:template match="experiences/lang">
    <div class="block" id="experiences">
      <h2 class="titre">
        <xsl:choose>
          <xsl:when test="@code='fr'">Expérience</xsl:when>
          <xsl:when test="@code='en'">Experience</xsl:when>
          <xsl:when test="@code='ar'">الخبرة</xsl:when>
        </xsl:choose>
      </h2>
      <div class="timeline-list">
        <xsl:for-each select="experience">
          <div class="timeline-item" typeof="portfolio:ProfessionalExperience">
            <div class="timeline-date"><xsl:value-of select="year"/></div>
            <div class="timeline-content">
              <h3 class="timeline-title">
                <span property="portfolio:jobTitle"><xsl:value-of select="position"/></span> • 
                <span property="portfolio:employer"><xsl:value-of select="company"/></span>
              </h3>
              <div class="timeline-location">
                <xsl:value-of select="location"/>
              </div>
              <div class="timeline-desc" property="dc:description">
                <xsl:value-of select="desc"/>
              </div>
              <div class="timeline-skills">
                <xsl:for-each select="skills/skill">
                  <span class="badge" property="portfolio:technicalSkill"><xsl:value-of select="."/></span>
                </xsl:for-each>
              </div>
            </div>
          </div>
        </xsl:for-each>
      </div>
    </div>
  </xsl:template>

  <!-- Projets  -->
  <xsl:template match="projects/lang">
    <div class="block" id="projects">
      <h2 class="titre">
        <xsl:choose>
          <xsl:when test="@code='fr'">Projets</xsl:when>
          <xsl:when test="@code='en'">Projects</xsl:when>
          <xsl:when test="@code='ar'">المشاريع</xsl:when>
        </xsl:choose>
      </h2>
      <div class="timeline-list">
        <xsl:for-each select="project">
          <div class="timeline-item" typeof="foaf:Project" about="#{@id}">
            <div class="timeline-date"><xsl:value-of select="domain"/></div>
            <div class="timeline-content">
              <h3 class="timeline-title">
                <xsl:choose>
                  <xsl:when test="link">
                    <a href="{link}" property="foaf:homepage" resource="{link}">
                      <span property="dc:title"><xsl:value-of select="title"/></span>
                    </a>
                  </xsl:when>
                  <xsl:otherwise>
                    <span property="dc:title"><xsl:value-of select="title"/></span>
                  </xsl:otherwise>
                </xsl:choose>
              </h3>
              <div class="timeline-desc" property="dc:description">
                <xsl:value-of select="desc"/>
              </div>
              <div class="timeline-skills">
                <xsl:for-each select="tech/skill">
                  <span class="badge" property="portfolio:technologyUsed"><xsl:value-of select="."/></span>
                </xsl:for-each>
              </div>
              <xsl:if test="link">
                <div style="margin-top: 15px;">
                  <a href="{link}">
                    <xsl:choose>
                      <xsl:when test="../@code='fr'">Voir le projet</xsl:when>
                      <xsl:when test="../@code='en'">View project</xsl:when>
                      <xsl:when test="../@code='ar'">عرض المشروع</xsl:when>
                    </xsl:choose>
                  </a>
                </div>
              </xsl:if>
            </div>
          </div>
        </xsl:for-each>
      </div>
    </div>
  </xsl:template>

  <!-- Compétences  -->
  <xsl:template match="skills/lang">
    <div class="block" id="skills">
      <h2 class="titre">
        <xsl:choose>
          <xsl:when test="@code='fr'">Compétences</xsl:when>
          <xsl:when test="@code='en'">Skills</xsl:when>
          <xsl:when test="@code='ar'">المهارات</xsl:when>
        </xsl:choose>
      </h2>
      <div class="timeline-list">
        <xsl:for-each select="category">
          <div class="timeline-item" typeof="portfolio:SkillCategory">
            <div class="timeline-date" property="dc:title"><xsl:value-of select="@name"/></div>
            <div class="timeline-content">
              <div class="timeline-skills">
                <xsl:for-each select="skill">
                  <span class="badge" property="portfolio:skill"><xsl:value-of select="."/></span>
                </xsl:for-each>
              </div>
            </div>
          </div>
        </xsl:for-each>
      </div>
    </div>
  </xsl:template>

  <!-- Centres d'intérêt -->
  <xsl:template match="interests/lang">
    <div class="block" id="interests">
      <h2 class="titre">
        <xsl:choose>
          <xsl:when test="@code='fr'">Centres d'intérêt</xsl:when>
          <xsl:when test="@code='en'">Interests</xsl:when>
          <xsl:when test="@code='ar'">الاهتمامات</xsl:when>
        </xsl:choose>
      </h2>
      <div class="timeline-item">
        <div class="timeline-date">
          <xsl:choose>
            <xsl:when test="@code='fr'">Loisirs</xsl:when>
            <xsl:when test="@code='en'">Hobbies</xsl:when>
            <xsl:when test="@code='ar'">الهوايات</xsl:when>
          </xsl:choose>
        </div>
        <div class="timeline-content">
          <ul>
            <xsl:for-each select="interest">
              <li property="foaf:interest"><xsl:value-of select="."/></li>
            </xsl:for-each>
          </ul>
        </div>
      </div>
    </div>
  </xsl:template>

</xsl:stylesheet>