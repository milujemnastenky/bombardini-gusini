document.addEventListener('DOMContentLoaded', function() {
    const fileList = document.getElementById('fileList');
    const fileContent = document.getElementById('fileContent');
    const searchInput = document.getElementById('searchInput');
    const searchButton = document.getElementById('searchButton');
    
    // Get repository name for GitHub Pages
    let repoPath = '';
    if (window.location.host.includes('github.io')) {
        const pathParts = window.location.pathname.split('/').filter(Boolean);
        if (pathParts.length > 0) {
            repoPath = pathParts[0];
        }
    }
    
    // Construct API URL
    const apiUrl = repoPath 
        ? `https://api.github.com/repos/${repoPath}/contents/data?ref=main`
        : 'https://api.github.com/repos/milujemnastenky/bombardini-gusini/contents/data?ref=main';
    
    // Display loading state
    fileList.innerHTML = '<div class="loading"><i class="fas fa-spinner fa-spin"></i> Loading files...</div>';
    
    // Fetch files from GitHub API
    fetch(apiUrl)
        .then(response => {
            if (!response.ok) {
                throw new Error(`Failed to fetch files. Status: ${response.status}`);
            }
            return response.json();
        })
        .then(files => {
            // Filter for .txt files
            const txtFiles = files.filter(file => 
                file.name.endsWith('.txt') && file.type === 'file'
            );
            
            if (txtFiles.length === 0) {
                fileList.innerHTML = '<div class="empty-state"><i class="fas fa-folder-open"></i><p>No text files found in the data directory</p></div>';
                return;
            }
            
            // Display file list
            fileList.innerHTML = '';
            txtFiles.forEach(file => {
                const fileItem = document.createElement('div');
                fileItem.className = 'file-item';
                fileItem.innerHTML = `
                    <i class="fas fa-file-alt"></i>
                    <span>${file.name}</span>
                `;
                
                fileItem.addEventListener('click', () => {
                    // Remove active class from all items
                    document.querySelectorAll('.file-item').forEach(item => {
                        item.classList.remove('active');
                    });
                    
                    // Add active class to clicked item
                    fileItem.classList.add('active');
                    
                    // Display loading state
                    fileContent.innerHTML = '<div class="loading"><i class="fas fa-spinner fa-spin"></i> Loading file content...</div>';
                    
                    // Fetch file content
                    fetch(file.download_url)
                        .then(response => {
                            if (!response.ok) {
                                throw new Error(`Failed to load file. Status: ${response.status}`);
                            }
                            return response.text();
                        })
                        .then(content => {
                            // Display file content with preserved whitespace
                            fileContent.innerHTML = `
                                <div class="file-header">
                                    <h2>${file.name}</h2>
                                    <small>${formatBytes(file.size)} • Last updated: ${new Date(file.updated_at).toLocaleDateString()}</small>
                                </div>
                                <pre class="file-text">${escapeHtml(content)}</pre>
                            `;
                        })
                        .catch(error => {
                            fileContent.innerHTML = `<div class="empty-state"><i class="fas fa-exclamation-circle"></i><p>Failed to load file: ${error.message}</p></div>`;
                        });
                });
                
                fileList.appendChild(fileItem);
            });
            
            // Select first file by default
            if (txtFiles.length > 0) {
                fileList.querySelector('.file-item').click();
            }
        })
        .catch(error => {
            fileList.innerHTML = `<div class="empty-state"><i class="fas fa-exclamation-circle"></i><p>Error loading files: ${error.message}</p></div>`;
            console.error('Error:', error);
        });
    
    // Search functionality
    searchButton.addEventListener('click', searchFiles);
    searchInput.addEventListener('keyup', function(e) {
        if (e.key === 'Enter') {
            searchFiles();
        }
    });
    
    function searchFiles() {
        const searchTerm = searchInput.value.toLowerCase();
        const fileItems = document.querySelectorAll('.file-item');
        
        fileItems.forEach(item => {
            const fileName = item.querySelector('span').textContent.toLowerCase();
            if (fileName.includes(searchTerm)) {
                item.style.display = 'flex';
            } else {
                item.style.display = 'none';
            }
        });
    }
    
    // Helper function to format file size
    function formatBytes(bytes) {
        if (bytes === 0) return '0 Bytes';
        const k = 1024;
        const sizes = ['Bytes', 'KB', 'MB', 'GB'];
        const i = Math.floor(Math.log(bytes) / Math.log(k));
        return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
    }
    
    // Helper function to escape HTML for display
    function escapeHtml(unsafe) {
        return unsafe
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#039;");
    }
});
