import { LightningElement, api, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import saveEvaluation from '@salesforce/apex/EvaluationController.saveEvaluation';
import getBarbecueStatus from '@salesforce/apex/EvaluationController.getBarbecueStatus';

export default class ScoreBarbecue extends LightningElement {
    @api recordId; // Id del presupuesto asado actual
    score = 0;
    observations = '';
    isCompleted = false;

    // Verificar el estado del asado
    @wire(getBarbecueStatus, { barbecueId: '$recordId' })
    wiredStatus({ error, data }) {
        if (data) {
            // Verificar si el estado es "Completado"
            this.isCompleted = data.Status__c === 'Completado';
        } else if (error) {
            this.showToast('Error', 'Error al obtener el estado del asado', 'error');
        }
    }

    // Manejar cambio de puntuación
    handleScoreChange(event) {
        this.score = event.target.value;
    }

    // Manejar cambio en las observaciones
    handleObservationsChange(event) {
        this.observations = event.target.value;
    }

    // Guardar la evaluación
    handleSave() {
        if (this.score < 1 || this.score > 10) {
            this.showToast('Error', 'La puntuación debe estar entre 1 y 10', 'error');
            return;
        }

        saveEvaluation({ barbecueId: this.recordId, score: this.score, observations: this.observations })
            .then(() => {
                this.showToast('Éxito', 'Evaluación guardada correctamente', 'success');
                this.score = 0;
                this.observations = '';
            })
            .catch((error) => {
                this.showToast('Error', 'Error al guardar la evaluación', 'error');
            });
    }

    // Mostrar notificaciones tipo toast
    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title,
            message,
            variant,
        });
        this.dispatchEvent(event);
    }
}