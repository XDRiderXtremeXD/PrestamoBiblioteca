<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

				<c:set var="positionClass" value="dropdown" />
				<c:if test="${param.menuType != '1'}">
				    <c:set var="positionClass" value="dropup" />
				</c:if>
				
				<div class="${positionClass}">
					<button class="btn btn-link nav-link py-2 dropdown-toggle d-flex align-items-center link-body-emphasis"
					        id="bd-theme"
					        type="button"
					        aria-expanded="false"
					        data-bs-toggle="dropdown"
					        aria-label="Toggle theme (auto)">
					  <svg class="bi my-1 theme-icon-active" width="1em" height="1em"><use href="#circle-half"></use></svg>
					  <span class="visually-hidden" id="bd-theme-text">Cambiar tema</span>
					</button>
					<ul class="dropdown-menu dropdown-menu-end shadow" aria-labelledby="bd-theme-text">
					  <li>
					    <button type="button" class="dropdown-item d-flex align-items-center" data-bs-theme-value="light" aria-pressed="false">
					      <svg class="bi me-2 opacity-50" width="1em" height="1em"><use href="#sun"></use></svg>
					      Claro
					      <svg class="bi ms-auto d-none" width="1em" height="1em"><use href="#check2"></use></svg>
					    </button>
					  </li>
					  <li>
					    <button type="button" class="dropdown-item d-flex align-items-center" data-bs-theme-value="dark" aria-pressed="false">
					      <svg class="bi me-2 opacity-50" width="1em" height="1em"><use href="#moon"></use></svg>
					      Oscuro
					      <svg class="bi ms-auto d-none" width="1em" height="1em"><use href="#check2"></use></svg>
					    </button>
					  </li>
					  <li>
					    <button type="button" class="dropdown-item d-flex align-items-center active" data-bs-theme-value="auto" aria-pressed="true">
					      <svg class="bi me-2 opacity-50" width="1em" height="1em"><use href="#circle-half"></use></svg>
					      Sistema
					      <svg class="bi ms-auto d-none" width="1em" height="1em"><use href="#check2"></use></svg>
					    </button>
					  </li>
					</ul>
				</div>
	
				<!-- Iconos SVG del boton de cambiar tema -->
				<svg xmlns="http://www.w3.org/2000/svg" class="d-none">
			      <symbol id="check2" viewBox="0 0 16 16">
			        <path d="M13.854 3.646a.5.5 0 0 1 0 .708l-7 7a.5.5 0 0 1-.708 0l-3.5-3.5a.5.5 0 1 1 .708-.708L6.5 10.293l6.646-6.647a.5.5 0 0 1 .708 0z"/>
			      </symbol>
			      <symbol id="circle-half" viewBox="0 0 16 16">
			        <path d="M8 15A7 7 0 1 0 8 1v14zm0 1A8 8 0 1 1 8 0a8 8 0 0 1 0 16z"/>
			      </symbol>
			      <symbol id="moon" viewBox="0 0 16 16">
			      	<path d="M6 .278a.77.77 0 0 1 .08.858 7.2 7.2 0 0 0-.878 3.46c0 4.021 3.278 7.277 7.318 7.277q.792-.001 1.533-.16a.79.79 0 0 1 .81.316.73.73 0 0 1-.031.893A8.35 8.35 0 0 1 8.344 16C3.734 16 0 12.286 0 7.71 0 4.266 2.114 1.312 5.124.06A.75.75 0 0 1 6 .278M4.858 1.311A7.27 7.27 0 0 0 1.025 7.71c0 4.02 3.279 7.276 7.319 7.276a7.32 7.32 0 0 0 5.205-2.162q-.506.063-1.029.063c-4.61 0-8.343-3.714-8.343-8.29 0-1.167.242-2.278.681-3.286"/>
			      </symbol>
			      <symbol id="sun" viewBox="0 0 16 16">
			      	<path d="M8 11a3 3 0 1 1 0-6 3 3 0 0 1 0 6m0 1a4 4 0 1 0 0-8 4 4 0 0 0 0 8M8 0a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 0m0 13a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 13m8-5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2a.5.5 0 0 1 .5.5M3 8a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2A.5.5 0 0 1 3 8m10.657-5.657a.5.5 0 0 1 0 .707l-1.414 1.415a.5.5 0 1 1-.707-.708l1.414-1.414a.5.5 0 0 1 .707 0m-9.193 9.193a.5.5 0 0 1 0 .707L3.05 13.657a.5.5 0 0 1-.707-.707l1.414-1.414a.5.5 0 0 1 .707 0m9.193 2.121a.5.5 0 0 1-.707 0l-1.414-1.414a.5.5 0 0 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .707M4.464 4.465a.5.5 0 0 1-.707 0L2.343 3.05a.5.5 0 1 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .708"/>
				  </symbol>
			    </svg>